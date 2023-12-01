input = File.readlines("#{__dir__}/../files/10.input").map(&:strip).map(&:to_i).sort

puts '='*20
puts 'part 1'

a = [0] + input
b = input + [a.last + 3]
differences = b.zip(a).map { |x, y| x - y }
distribution = differences.group_by(&:itself).transform_values(&:length)

puts distribution[1] * distribution[3]

puts '='*20
puts 'part 2'

paths = { 0 => 1 }

b.each do |n|
  paths[n] = paths.fetch(n - 1, 0) + paths.fetch(n - 2, 0) + paths.fetch(n - 3, 0)
end

puts paths[b.last]
