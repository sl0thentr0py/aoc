require 'set'

input = File.read("#{__dir__}/../files/06.input")
groups = input.split("\n\n").map { |group| group.split.map { |a| Set.new(a.chars) } }

puts '='*20
puts 'part 1'
puts groups.map { |g| g.inject(:|).size }.sum

puts '='*20
puts 'part 2'
puts groups.map { |g| g.inject(:&).size }.sum
