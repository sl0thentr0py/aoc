def valid?(n)
  digits = n.to_s.chars.map(&:to_i)

  digits.sort == digits && #increasing
    digits.group_by(&:itself).values.map(&:length).any? { |x| x > 1 }
end

def valid2?(n)
  digits = n.to_s.chars.map(&:to_i)

  digits.sort == digits && #increasing
    digits.group_by(&:itself).values.map(&:length).any? { |x| x == 2 }
end

p (266666..781584).count { |n| valid?(n) }

p (266666..781584).count { |n| valid2?(n) }
