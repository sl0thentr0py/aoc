require 'pry'

NUM = File.basename($0).scan(/\d+/).first
input = File.read("#{__dir__}/../files/#{NUM}.input")

def part1(input)
end

def part2(input)
end

puts '='*20
puts 'part 1'
puts part1(input)

puts '='*20
puts 'part 2'
puts part2(input)
