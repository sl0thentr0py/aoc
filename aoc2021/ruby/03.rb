require 'pry'

input = File.read("#{__dir__}/../files/03.input")

# input = '00100
# 11110
# 10110
# 10111
# 10101
# 01111
# 00111
# 11100
# 10000
# 11001
# 00010
# 01010'

def commons(matrix)
  numrows = matrix.length

  # sum all the rows
  sums = matrix.reduce do |sum, row|
    sum.zip(row).map { |x, y| x + y }
  end

  sums.map { |s| s >= (numrows / 2 + numrows % 2) ? 1 : 0 }
end

def xor(arr)
  arr.map { |x| x ^ 1 }
end

def decimal(arr)
  arr.reverse.map.with_index { |x, i| x * 2 ** i }.sum
end

def recurse(candidates, index: 0, flip: false)
  return candidates.first if candidates.length == 1

  filter = commons(candidates)
  filter = xor(filter) if flip
  filtered_candidates = candidates.select { |r| r[index] == filter[index] }
  recurse(filtered_candidates, index: index + 1, flip: flip)
end

def part1(matrix)
  more = commons(matrix)
  less = xor(more)
  decimal(more) * decimal(less)
end

def part2(matrix)
  o2 = recurse(matrix)
  co2 = recurse(matrix, flip: true)
  decimal(o2) * decimal(co2)
end

matrix = input.split("\n").map { |row| row.chars.map(&:to_i) }

puts '='*20
puts 'part 1'
puts part1(matrix)

puts '='*20
puts 'part 2'
puts part2(matrix)
