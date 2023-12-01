input = File.readlines("#{__dir__}/../files/01.input").map(&:strip).map(&:to_i)

puts '='*20
puts 'part 1'
puts input.combination(2).find { |a, b| a + b == 2020 }.inject(1, :*)

puts '='*20
puts 'part 2'
puts input.combination(3).find { |a, b, c| a + b + c == 2020 }.inject(1, :*)
