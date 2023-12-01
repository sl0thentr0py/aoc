require 'pry'

input = File.read("#{__dir__}/../files/06.input")

# input = '3,4,3,1,2'

OFFSPRING_LIFE = 8
PARENT_LIFE = 6

def simulate(old_school, days)
  return old_school if days == 0

  new_school = Hash.new(0)
  num_reproduce = old_school.delete(0)

  old_school.each { |age, num| new_school[age - 1] = num }

  if num_reproduce
    new_school[OFFSPRING_LIFE] += num_reproduce
    new_school[PARENT_LIFE] += num_reproduce
  end

  simulate(new_school, days - 1)
end

def tally(input)
  input.split(',').map(&:to_i).group_by(&:itself).transform_values(&:count)
end

def part1(input)
  school = tally(input)
  simulate(school, 80).values.sum
end

def part2(input)
  school = tally(input)
  simulate(school, 256).values.sum
end

puts '='*20
puts 'part 1'
puts part1(input)

puts '='*20
puts 'part 2'
puts part2(input)
