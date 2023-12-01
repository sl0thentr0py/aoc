input = File.read("#{__dir__}/../files/02.input")

test_input = 'A Y
B X
C Z'

input = test_input if ARGV.include?("test")

# ==========================================================
# rock - 0, paper - 1, scissors - 2, cyclic modulo 3

strats = input.split("\n").map(&:split).map { |x, y| [x.ord - "A".ord, y.ord - "X".ord] }

def score1(x, y)
  y + 1 + ((x + 1) % 3 == y ? 6 : (x == y ? 3 : 0))
end

def score2(x, y)
  move = y == 1 ? x : (y == 2 ? ((x + 1) % 3) : ((x - 1) % 3))
  (y * 3) + move + 1
end

def part1(strats)
  strats.map { |x, y| score1(x, y) }.sum
end

def part2(strats)
  strats.map { |x, y| score2(x, y) }.sum
end

# ==========================================================

puts '='*20
puts 'part 1'
puts part1(strats)

puts '='*20
puts 'part 2'
puts part2(strats)
