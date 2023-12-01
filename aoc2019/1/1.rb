def fuel(m)
  [(m / 3) - 2, 0].max
end

input = File.readlines('input').map(&:strip).map(&:to_i)
out = input.map { |x| fuel(x) }.sum
p out

####

def r_fuel(m)
  f = fuel(m)

  if f == 0
    0
  else
    f + r_fuel(f)
  end
end

out2 = input.map { |x| r_fuel(x) }.sum
p out2
