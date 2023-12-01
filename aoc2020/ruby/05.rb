input = File.readlines("#{__dir__}/../files/05.input").map(&:strip)

def seat(pass)
  pass.gsub(/[FBLR]/, 'F' => '0', 'B' => '1', 'L' => '0', 'R' => '1').to_i(2)
end

seats = input.map { |p| seat(p) }.sort

puts '='*20
puts 'part 1'
puts seats.last

puts '='*20
puts 'part 2'

*shifted, _last = [seats.first - 1] + seats
puts seats.zip(shifted).find { |x, y| x - y > 1 }.first - 1
