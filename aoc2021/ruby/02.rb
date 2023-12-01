require 'pry'

input = File.read("#{__dir__}/../files/02.input")

# input = 'forward 5
# down 5
# forward 8
# up 3
# down 8
# forward 2'

instructions = input.split("\n")

class Sub
  attr_reader :depth, :pos

  def initialize
    @depth, @pos = 0, 0
  end

  def process(instruction)
    op, num = instruction.split
    op = op.to_sym
    num = num.to_i

    case op
    when :forward
      @pos += num
    when :down
      @depth += num
    when :up
      @depth -= num
    end
  end
end

class Sub2
  attr_reader :depth, :pos, :aim

  def initialize
    @depth, @pos, @aim = 0, 0, 0
  end

  def process(instruction)
    op, num = instruction.split
    op = op.to_sym
    num = num.to_i

    case op
    when :forward
      @pos += num
      @depth += num * @aim
    when :down
      @aim += num
    when :up
      @aim -= num
    end
  end
end

def part1(instructions)
  sub = Sub.new
  instructions.each { |i| sub.process(i) }
  sub.depth * sub.pos
end

def part2(instructions)
  sub = Sub2.new
  instructions.each { |i| sub.process(i) }
  sub.depth * sub.pos
end

puts '='*20
puts 'part 1'
puts part1(instructions)

puts '='*20
puts 'part 2'
puts part2(instructions)
