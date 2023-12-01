require 'pry'

input = File.read("#{__dir__}/../files/07.input")

# input = '16,1,2,0,4,2,7,1,2,14'

def median(arr)
  sorted = arr.sort
  n = sorted.length
  (sorted[(n - 1) / 2] + sorted[n / 2]) / 2.0
end

def mean(arr)
  sorted = arr.sort
  n = sorted.length
  arr.sum * 1.0 / n
end

def sum_n(n)
  n * (n + 1) / 2.0
end

# median minimizes l1-norm
def part1(input)
  arr = input.split(',').map(&:to_i)
  median = median(arr)
  arr.map { |x| (x - median).abs }.sum.to_i
end

def part2(input)
  arr = input.split(',').map(&:to_i)
  mean = mean(arr)
  x1, x2 = [mean.floor, mean.ceil]

  [
    arr.map { |x| sum_n((x - x1).abs) }.sum.to_i,
    arr.map { |x| sum_n((x - x2).abs) }.sum.to_i,
  ].min
end

puts '='*20
puts 'part 1'
puts part1(input)

puts '='*20
puts 'part 2'
puts part2(input)
