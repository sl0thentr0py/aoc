class Passport
  REQUIRED = %w(ecl pid eyr hcl byr iyr hgt)

  def initialize(data)
    @hash = data.split.map { |x| x.split(':') }.to_h
  end

  def valid1?
    (REQUIRED - @hash.keys).empty?
  end

  def valid2?
    valid1? && REQUIRED.all? { |k| send("valid_#{k}?") }
  end

  def valid_byr?
    val = @hash['byr'].to_i
    val >= 1920 && val <= 2002
  end

  def valid_iyr?
    val = @hash['iyr'].to_i
    val >= 2010 && val <= 2020
  end

  def valid_eyr?
    val = @hash['eyr'].to_i
    val >= 2020 && val <= 2030
  end

  def valid_hgt?
    val, unit = @hash['hgt'].match(/^(\d+)(.*)$/).captures
    val = val.to_i

    (unit == 'cm' && val >= 150 && val <= 193) ||
      (unit == 'in' && val >= 59 && val <= 76)
  end

  def valid_hcl?
    @hash['hcl'].match?(/^#[0-9a-f]{6}$/)
  end

  def valid_ecl?
    %w(amb blu brn gry grn hzl oth).include?(@hash['ecl'])
  end

  def valid_pid?
    @hash['pid'].match?(/^[0-9]{9}$/)
  end
end

input = File.read("#{__dir__}/../files/04.input")

puts '='*20
puts 'part 1'
puts input.split("\n\n").count { |data| Passport.new(data).valid1? }

puts '='*20
puts 'part 2'
puts input.split("\n\n").count { |data| Passport.new(data).valid2? }
