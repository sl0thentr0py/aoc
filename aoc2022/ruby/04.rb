input = File.read("#{__dir__}/../files/04.input")

test_input = '2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8'

input = test_input if ARGV.include?("test")

# ==========================================================

regex = /(\d+)-(\d+),(\d+)-(\d+)/
ranges = input.split("\n").map { |l| regex.match(l).captures.map(&:to_i) }

def part1(ranges)
  ranges.count { |a, b, x, y| a <= x && b >= y || a >= x && b <= y }
end

def part2(ranges)
  ranges.count { |a, b, x, y| a <= x && b >= x || x <= a && y >= a }
end

# ==========================================================

puts '='*20
puts 'part 1'
puts part1(ranges)

puts '='*20
puts 'part 2'
puts part2(ranges)
