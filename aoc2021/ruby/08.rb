require 'pry'
require 'set'

input = File.read("#{__dir__}/../files/08.input")

# input = 'be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
# edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
# fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
# fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
# aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
# fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
# dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
# bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
# egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
# gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce'


def tally(arr)
  arr.group_by(&:itself).transform_values(&:count)
end

class Display
  PATTERNS = %w(
    abcefg
    cf
    acdeg
    acdfg
    bcdf
    abdfg
    abdefg
    acf
    abcdefg
    abcdfg
  )

  DIGITS = PATTERNS.map.with_index { |p, i| [p.chars.to_set, i] }.to_h

  def initialize(line)
    @inputs, @outputs = line.split(" | ").map(&:split)
    @mapping = {}
  end

  def output
    infer

    @outputs.map do |o|
      mapped = o.chars.map { |c| @mapping[c] }.to_set
      DIGITS[mapped]
    end.join.to_i
  end

  private

  def infer
    c1 = @inputs.find { |x| x.length == 2 }.chars.to_set
    c4 = @inputs.find { |x| x.length == 4 }.chars.to_set
    c7 = @inputs.find { |x| x.length == 3 }.chars.to_set
    c8 = @inputs.find { |x| x.length == 7 }.chars.to_set

    c5s = @inputs.select { |x| x.length == 5 }.map { |x| x.chars.to_set }
    c5_intersection = c5s.reduce(:&)

    c6s = @inputs.select { |x| x.length == 6 }.map { |x| x.chars.to_set }
    c6_intersection = c6s.reduce(:&)

    a = c7 - c1
    g = (c5_intersection & c6_intersection) - a
    e = c8 - c4 - a - g
    d = c5_intersection - a - g
    b = c8 - c7 - d - e - g
    f = c6_intersection - a - b - g
    c = (c8 & c7) - a - f

    ordered = [a, b, c, d, e, f, g].map(&:first)
    @mapping = ordered.zip(%w(a b c d e f g)).to_h
  end
end

def part1(input)
  uniq_lengths = tally(Display::PATTERNS.map(&:length)).select { |k, v| v == 1 }.keys

  input.split("\n").map do |line|
    line.split(" | ").last.split.count { |x| uniq_lengths.include?(x.length) }
  end.sum
end

def part2(input)
  input.split("\n").map do |line|
    d = Display.new(line)
    d.output
  end.sum
end

puts '='*20
puts 'part 1'
puts part1(input)

puts '='*20
puts 'part 2'
puts part2(input)
