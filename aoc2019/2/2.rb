class Computer

  attr_accessor :pc, :tape, :instruction

  def initialize(input)
    @tape = input.dup
    @pc = 0
    @instruction = nil
  end

  def reset(input)
    @tape = input.dup
    @pc = 0
    @instruction = nil
  end

  def mode(noun, verb)
    @tape[1] = noun
    @tape[2] = verb
  end

  def mode_1202
    mode(12, 2)
  end

  def next_instruction
    @instruction = @tape.slice(@pc, @pc + 4)
  end

  def opcode
    @instruction[0]
  end

  def operand1
    @tape[@instruction[1]]
  end

  def operand2
    @tape[@instruction[2]]
  end

  def arithmetic(opcode)
    result = opcode == 1 ? operand1 + operand2 : operand1 * operand2
    @tape[@instruction[3]] = result
  end

  def execute_instruction
    return false if opcode == 99
    raise "Invalid instruction" unless [1, 2].include?(opcode)

    arithmetic(opcode)
    @pc += 4
    true
  end

  def execute
    next_instruction
    return unless execute_instruction
    execute
  end

  def output
    @tape[0]
  end
end

input = File::read('input').strip.split(',').map(&:to_i).freeze
c = Computer.new(input)
c.mode_1202
c.execute
p c.output

p '--------------------'

########

def brute_force(c, input, seek)
  verbs = nouns = (0..99)

  verbs.each do |verb|
    nouns.each do |noun|
      p "trying (#{noun}, #{verb})"
      c.reset(input)
      c.mode(noun, verb)
      c.execute
      return [noun, verb] if c.output == seek
    end
  end
end

noun, verb = brute_force(c, input, 19690720)
p 100 * noun + verb
