require 'pry'

NUM = File.basename($0).scan(/\d+/).first
input = File.read("#{__dir__}/../files/#{NUM}.input")

# input = '[({(<(())[]>[[{[]{<()<>>
# [(()[<>])]({[<{<<[]>>(
# {([(<{}[<>[]}>{[]{[(<()>
# (((({<>}<{<{<>}{[]{[]{}
# [[<[([]))<([[{}[[()]]]
# [{[{({}]{}}([{[{{{}}([]
# {<[[]]>}<{[{[{[]{()[[[]
# [<(<(<(<{}))><([]([]()
# <{([([[(<>()){}]>(<<{{
# <{([{{}}[<[[[<>{}]]]>[]]
# '

class Parser
  OPENS = %w([ \( < {)
  CLOSES = %w(] \) > })
  MATCHES = CLOSES.zip(OPENS).to_h
  REVERSE_MATCHES = OPENS.zip(CLOSES).to_h
  SCORES = CLOSES.zip([57, 3, 25137, 1197]).to_h
  SCORES2 = CLOSES.zip([2, 1, 4, 3]).to_h

  def initialize(line)
    @line = line
    @stack = []
  end

  def parse
    @line.chars.each do |char|
      if OPENS.include?(char)
        @stack << char
      elsif MATCHES[char] != @stack.pop
        return SCORES[char]
      end
    end

    nil
  end

  def repair
    @stack.reverse.map { |c| REVERSE_MATCHES[c] }.
      reduce(0) { |score, c| score * 5 + SCORES2[c] }
  end
end

def part1(input)
  input.split("\n").map { |l| Parser.new(l).parse }.compact.sum
end

def part2(input)
  parsers = input.split("\n").map { |l| Parser.new(l) }
  incomplete = parsers.reject(&:parse)
  incomplete.map(&:repair).sort[incomplete.length / 2]
end

puts '='*20
puts 'part 1'
puts part1(input)

puts '='*20
puts 'part 2'
puts part2(input)
