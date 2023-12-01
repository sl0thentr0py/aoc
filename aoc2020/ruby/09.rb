require 'set'

class Cipher
  def initialize(input, preamble_size = 25)
    @input = input
    @preamble_size = preamble_size
  end

  def find_error
    @input.drop(@preamble_size).each_with_index.find do |n, i|
      checksum_fail?(@input.slice(i, i + @preamble_size), n)
    end.first
  end

  def checksum_fail?(slice, n)
    s1 = Set.new(slice)
    s2 = Set.new(slice.map { |x| n - x })

    intersection = s1 & s2
    intersection.delete(n / 2) if n.even?

    intersection.empty?
  end

  def contiguous(n)
    window = []
    sum = 0

    @input.each do |i|
      break if sum == n
      window << i
      sum += i
      sum -= window.shift while sum > n
    end

    window.min + window.max
  end
end

input = File.readlines("#{__dir__}/../files/09.input").map(&:strip).map(&:to_i)

cipher = Cipher.new(input)
error = cipher.find_error
window = cipher.contiguous(error)

puts '='*20
puts 'part 1'
puts error

puts '='*20
puts 'part 2'
puts window

