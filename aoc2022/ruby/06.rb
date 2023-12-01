n = "06"
input = File.read("#{__dir__}/../files/#{n}.input")

test_input = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'

input = test_input if ARGV.include?("test")

# ==========================================================


def solve(input, n)
  input.chars.each_cons(n).find_index { |x| x.uniq.size == n } + n
end

# ==========================================================

puts '='*20
puts 'part 1'
puts solve(input, 4)

puts '='*20
puts 'part 2'
puts solve(input, 14)
