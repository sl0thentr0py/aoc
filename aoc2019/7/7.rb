require 'pry'

class Computer

  attr_accessor :pc, :tape, :input, :output, :instruction

  STEPS = { halt: 1, arithmetic: 4, io: 2, jump: 3, compare: 4 }

  def initialize(program)
    @tape = program.dup
    @pc = 0
    @instruction = nil
    @jumped = false
    @input = []
    @output = []
    @state = :running
  end

  def execute
    return unless read_instruction
    execute_instruction
    return if @state == :halted

    @pc += steps unless @jumped
    @jumped = false # fugly

    execute
  end

  def execute_till_output
    return unless @output.empty?
    return unless read_instruction

    execute_instruction
    return if @state == :halted

    @pc += steps unless @jumped
    @jumped = false # fugly

    execute_till_output
  end

  def halted?
    @state == :halted
  end

  private

  def steps
    STEPS[opcode_type]
  end

  def opcode
    @tape[@pc]
  end

  def opcode_s
    opcode.to_s
  end

  def opcode_last
    opcode_s.chars.last.to_i
  end

  def opcode_type
    return :halt if opcode == 99

    case opcode_last
    when 1, 2
      :arithmetic
    when 3, 4
      :io
    when 5, 6
      :jump
    when 7, 8
      :compare
    else
      :unknown
    end
  end


  def operand1_type
    return :immediate if opcode_s.length == 3 && opcode_s[0] == '1'
    return :immediate if opcode_s.length == 4 && opcode_s[1] == '1'
    :position
  end

  def operand2_type
    return :immediate if opcode_s.length == 4 && opcode_s[0] == '1'
    :position
  end

  def operand1
    case operand1_type
    when :position
      @tape[@instruction[1]]
    when :immediate
      @instruction[1]
    end
  end

  def operand2
    case operand2_type
    when :position
      @tape[@instruction[2]]
    when :immediate
      @instruction[2]
    end
  end

  def execute_arithmetic
    result = opcode_last == 1 ? operand1 + operand2 : operand1 * operand2
    @tape[@instruction[3]] = result
  end

  def execute_io
    case opcode_last
    when 3
      @tape[@instruction[1]] = @input.shift
    when 4
      @output.push(operand1)
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
    @tape[@instruction[3]] = cond ? 1 : 0
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
    else
      raise 'Unknwown instruction'
    end
  end

end

class Amplifier
  attr_accessor :output

  def initialize(program, phase)
    @computer = Computer.new(program)
    @computer.input << phase
  end

  def run(signal)
    @computer.input << signal
    @computer.execute_till_output
    @output = @computer.output.shift
  end

  def halted?
    @computer.halted?
  end
end

class Circuit
  def initialize(program, phases)
    @amplifiers = phases.map { |p| Amplifier.new(program, p) }
    @current_amp_index = 0
    @signal = 0
  end

  def current_amp
    @amplifiers[@current_amp_index]
  end

  def run
    current_amp.run(@signal)
    @signal = current_amp.output
    return if halt?
    @current_amp_index = next_amp_index
    run
  end

  def output
    @amplifiers[4].output
  end
end

class LinearCircuit < Circuit
  def halt?
    @current_amp_index == 4
  end

  def next_amp_index
    @current_amp_index + 1
  end
end

class FeedbackCircuit < Circuit
  def halt?
    current_amp.halted?
  end

  def next_amp_index
    return 0 if @current_amp_index == 4
    @current_amp_index + 1
  end
end

program = File::read('input').strip.split(',').map(&:to_i)

##### Part 1
outs = (0..4).to_a.permutation.map do |phases|
  l = LinearCircuit.new(program, phases)
  l.run
  l.output
end

p outs.max

###### Part 2
outs2 = (5..9).to_a.permutation.map do |phases|
  l = FeedbackCircuit.new(program, phases)
  l.run
  l.output
end

p outs2.max
