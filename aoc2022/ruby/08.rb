require 'debug'
n = "08"
input = File.read("#{__dir__}/../files/#{n}.input")

test_input = '30373
25512
65332
33549
35390'

input = test_input if ARGV.include?("test")

# ==========================================================

matrix = input.split("\n").map { |x| x.chars.map(&:to_i) }

def visible(row)
  maxs = row.reduce([-1]) { |ms, x| ms << [x, ms.last].max }
  row.zip(maxs).map { |x, m| x > m }
end

def score(row)
  row.each_with_index.map do |x, i|
    next 0 if i == 0
    ind = row[0...i].reverse.find_index { |y| y >= x }
    ind ? ind + 1 : i
  end
end

def part1(matrix)
  [
    matrix.map { |r| visible(r) },
    matrix.map { |r| visible(r.reverse).reverse },
    matrix.transpose.map { |r| visible(r) }.transpose,
    matrix.transpose.map { |r| visible(r.reverse).reverse }.transpose
  ].reduce do |m1, m2|
    m1.zip(m2).map { |r1, r2| r1.zip(r2).map { |x, y| x || y } }
  end.flatten.count(true)
end

def part2(matrix)
  [
    matrix.map { |r| score(r) },
    matrix.map { |r| score(r.reverse).reverse },
    matrix.transpose.map { |r| score(r) }.transpose,
    matrix.transpose.map { |r| score(r.reverse).reverse }.transpose
  ].reduce do |m1, m2|
    m1.zip(m2).map { |r1, r2| r1.zip(r2).map { |x, y| x * y } }
  end.flatten.max
end

# ==========================================================

puts '='*20
puts 'part 1'
pp part1(matrix)

puts '='*20
puts 'part 2'
puts part2(matrix)
