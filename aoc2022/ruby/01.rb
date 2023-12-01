input = File.read("#{__dir__}/../files/01.input")

test_input = '1000
2000
3000

4000

5000
6000

7000
8000
9000

10000'

input = test_input if ARGV.include?("test")

# ==========================================================

calories = input.split("\n\n").map { |x| x.split("\n").map(&:to_i) }

def part1(calories)
  calories.map(&:sum).max
end

def part2(calories)
  calories.map(&:sum).sort.last(3).sum
end

# ==========================================================

puts '='*20
puts 'part 1'
puts part1(calories)

puts '='*20
puts 'part 2'
puts part2(calories)
