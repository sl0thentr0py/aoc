require 'pry'

class Computer

  attr_accessor :pc, :tape, :instruction, :input, :output

  STEPS = {
    io: 2,
    halt: 1,
    jump: 3,
    compare: 4,
    rb_offset: 2,
    arithmetic: 4
  }

  def initialize(program)
    @tape = program.dup
    @pc = 0
    @instruction = nil

    @relative_base = 0

    @jumped = false
    @state = :running

    @input = []
    @output = []
  end

  def execute
    while !halted? do
      read_instruction
      execute_instruction
      update_pc
    end
  end

  def execute_till_output
    while !halted? && @output.empty? do
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
      offset = operand1_type == :relative ? @relative_base : 0
      @tape[offset + @instruction[1]] = @input.shift
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

class Robot
  attr_accessor :grid

  def initialize(program)
    @computer = Computer.new(program)
    @grid = Hash.new(0)
    @x = 0
    @y = 0
    @direction = :up
  end

  def run
    return if @computer.halted?
    @computer.input << @grid[[@x, @y]]

    @computer.execute_till_output
    color = @computer.output.shift

    @computer.execute_till_output
    turn = @computer.output.shift

    @grid[[@x, @y]] = color
    move(turn)

    run
  end

  private

  def move(output)
    case output
    when 0 then move_left
    when 1 then move_right
    end
  end

  def move_left
    case @direction
    when :up
      @x -= 1
      @direction = :left
    when :left
      @y += 1
      @direction = :down
    when :down
      @x += 1
      @direction = :right
    when :right
      @y -= 1
      @direction = :up
    end
  end

  def move_right
    case @direction
    when :up
      @x += 1
      @direction = :right
    when :right
      @y += 1
      @direction = :down
    when :down
      @x -= 1
      @direction = :left
    when :left
      @y -= 1
      @direction = :up
    end
  end
end


program = File::read('input').strip.split(',').map(&:to_i)
c = Robot.new(program)
c.run
p c.grid.keys.size

#####
def print_grid(grid)
  x0 = grid.keys.map(&:first).min
  x1 = grid.keys.map(&:first).max
  y0 = grid.keys.map(&:last).min
  y1 = grid.keys.map(&:last).max

  (y0..y1).each do |y|
    (x0..x1).each do |x|
      print grid[[x, y]] == 1 ? 'X' : ' '
    end
    print "\n"
  end
end

c = Robot.new(program)
c.grid[[0, 0]] = 1
c.run
print_grid(c.grid)

