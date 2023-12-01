require 'pry'

class Computer
  PARSER_REGEX = /^(acc|jmp|nop) ([+-]\d+)$/

  attr_accessor :accumulator, :toggle

  def initialize(instructions)
    @instructions = instructions
    reset
  end

  def reset
    @accumulator = 0
    @pc = 0
    @history = []
    @toggle = nil
  end

  def execute
    return false if @history.include?(@pc)
    return true unless current_instruction
    @history << @pc

    op, arg = parse_instruction

    case op
    when :acc
      @accumulator += arg.to_i
      @pc += 1
    when :jmp
      @pc += arg.to_i
    when :nop
      @pc += 1
    end

    execute
  end

  def current_instruction
    @instructions[@pc]
  end

  def parse_instruction
    op, arg = current_instruction.match(PARSER_REGEX).captures
    op = op.to_sym

    if @toggle == @pc
      if op == :jmp
        op = :nop
      elsif op == :nop
        op = :jmp
      end
    end

    [op, arg]
  end

  def op_jmps
    @instructions.each_with_index.
      select { |inst, i| %w(jmp nop).include?(inst.match(PARSER_REGEX).captures.first) }.
      map(&:last)
  end
end

input = File.readlines("#{__dir__}/../files/08.input").map(&:strip)

c = Computer.new(input)
c.execute

puts '='*20
puts 'part 1'
puts c.accumulator

puts '='*20
puts 'part 2'

c.op_jmps.each do |toggle|
  c.reset
  c.toggle = toggle
  break if c.execute
end

puts c.accumulator
