class Password
  REGEX = /(\d+)-(\d+) (.): (.*)/

  def initialize(s)
    @min, @max, @char, @pass = s.match(REGEX).captures
    @min = @min.to_i
    @max = @max.to_i
  end

  def valid1?
    @pass.count(@char).between?(@min, @max)
  end

  # ^ = xor
  def valid2?
    !!(@pass[@min - 1] == @char) ^ !!(@pass[@max - 1] == @char)
  end
end

input = File.readlines("#{__dir__}/../files/02.input").map(&:strip)
passwords = input.map { |s| Password.new(s) }

puts '='*20
puts 'part 1'
puts passwords.count(&:valid1?)

puts '='*20
puts 'part 2'
puts passwords.count(&:valid2?)
