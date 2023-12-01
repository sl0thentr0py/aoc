require 'pry'

class Computer

  attr_accessor :pc, :tape, :instruction

  STEPS = {
    io: 2,
    halt: 1,
    jump: 3,
    compare: 4,
    rb_offset: 2,
    arithmetic: 4
  }

  def initialize(input)
    @tape = input.dup
    @pc = 0
    @instruction = nil

    @relative_base = 0

    @jumped = false
    @state = :running
  end

  def execute
    while !halted? do
      read_instruction
      execute_instruction
      update_pc
    end
  end

  def halted?
    @state == :halted
  end

  private

  def update_pc
    if @jumped
      @jumped = false
    else
      @pc += steps
    end
  end

  def steps
    STEPS[opcode_type]
  end

  def opcode
    code = @tape[@pc].to_s
    "#{'0' * (5 - code.length)}#{code}" ## extend with zeroes
  end

  def opcode_last
    opcode[-1].to_i
  end

  def opcode_type
    return :halt if opcode.end_with?('99')

    case opcode_last
    when 1, 2
      :arithmetic
    when 3, 4
      :io
    when 5, 6
      :jump
    when 7, 8
      :compare
    when 9
      :rb_offset
    else
      :unknown
    end
  end

  def operand1_type
    mode(opcode[2])
  end

  def operand2_type
    mode(opcode[1])
  end

  def operand3_type
    mode(opcode[0])
  end

  def mode(c)
    case c.to_i
    when 0 then :position
    when 1 then :immediate
    when 2 then :relative
    end
  end

  def operand1
    case operand1_type
    when :position
      read_tape(@instruction[1])
    when :relative
      read_tape(@relative_base + @instruction[1])
    when :immediate
      @instruction[1]
    end
  end

  def operand2
    case operand2_type
    when :position
      read_tape(@instruction[2])
    when :relative
      read_tape(@relative_base + @instruction[2])
    when :immediate
      @instruction[2]
    end
  end

  def execute_arithmetic
    result = opcode_last == 1 ? operand1 + operand2 : operand1 * operand2
    offset = operand3_type == :relative ? @relative_base : 0
    @tape[offset + @instruction[3]] = result
  end

  def execute_io
    case opcode_last
    when 3
      puts 'Input..'
      offset = operand1_type == :relative ? @relative_base : 0
      @tape[offset + @instruction[1]] = gets.strip.to_i
      puts '------'
    when 4
      puts "Output: #{operand1}"
    end
  end

  def execute_jump
    cond = opcode_last == 5 ? operand1 != 0 : operand1 == 0

    if cond
      @pc = operand2
      @jumped = true
    end
  end

  def execute_compare
    cond = opcode_last == 7 ? operand1 < operand2 : operand1 == operand2
    offset = operand3_type == :relative ? @relative_base : 0
    @tape[offset + @instruction[3]] = cond ? 1 : 0
  end

  def execute_rb_offset
    @relative_base += operand1
  end

  def read_instruction
    @instruction = @tape.slice(@pc...@pc + steps)
  end

  def execute_instruction
    case opcode_type
    when :halt
      @state = :halted
    when :arithmetic
      execute_arithmetic
    when :io
      execute_io
    when :jump
      execute_jump
    when :compare
      execute_compare
    when :rb_offset
      execute_rb_offset
    else
      raise 'Unknwown instruction'
    end
  end

  def read_tape(at)
    @tape[at] || 0
  end

end


## tests
# input = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99]
# input = [1102,34915192,34915192,7,4,7,99,0]
# input = [104,1125899906842624,99]

input = File::read('input').strip.split(',').map(&:to_i)
c = Computer.new(input)
c.execute
