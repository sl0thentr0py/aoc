input = File.readlines("#{__dir__}/../files/01.input").map(&:strip).map(&:to_i)

# input = '199
# 200
# 208
# 210
# 200
# 207
# 240
# 269
# 260
# 263'.split.map(&:strip).map(&:to_i)

def part1(arr)
  arr.each_cons(2).map { |x, y| y - x }.count { |x| x > 0 }
end

def part2(arr)
  part1(arr.each_cons(3).map(&:sum))
end

puts '='*20
puts 'part 1'
puts part1(input)

puts '='*20
puts 'part 2'
puts part2(input)
