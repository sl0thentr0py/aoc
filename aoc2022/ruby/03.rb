input = File.read("#{__dir__}/../files/03.input")

test_input = 'vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw'

input = test_input if ARGV.include?("test")

# ==========================================================

require 'set'

sacks = input.split("\n")
compartments = sacks.map { |x| x.chars.each_slice(x.size / 2).map(&:to_set) }
groups = sacks.each_slice(3).map { |g| g.map {|x| x.chars.to_set } }

def prio(c)
  (c.ord - 96) % 58
end

def part1(compartments)
  compartments.map { |x, y| prio((x & y).first) }.sum
end

def part2(groups)
  groups.map { |x, y, z| prio((x & y & z).first) }.sum
end

# ==========================================================

puts '='*20
puts 'part 1'
puts part1(compartments)

puts '='*20
puts 'part 2'
puts part2(groups)
