n = "05"
input = File.read("#{__dir__}/../files/#{n}.input")

test_input = '    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2'

input = test_input if ARGV.include?("test")

# ==========================================================

s, i = input.split("\n\n")

stacks = s.split("\n").reverse.drop(1).
  map { |l| l.chars.select.with_index{ |_, i| (i-1) % 4 == 0 } }.
  transpose.
  map { |x| x.reject { |y| y == " " } }

instructions = i.split("\n").map { |l| /move (\d+) from (\d+) to (\d+)/.match(l).captures.map(&:to_i) }

def part1(stacks, instructions)
  instructions.each do |num, from, to|
    stacks[to-1].push(*stacks[from-1].pop(num).reverse)
  end

  stacks.map(&:last).join
end

def part2(stacks, instructions)
  instructions.each do |num, from, to|
    stacks[to-1].push(*stacks[from-1].pop(num))
  end

  stacks.map(&:last).join
end

# ==========================================================

puts '='*20
puts 'part 1'
puts part1(stacks.map(&:clone), instructions)

puts '='*20
puts 'part 2'
puts part2(stacks.map(&:clone), instructions)
