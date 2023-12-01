require 'debug'
n = "07"
input = File.read("#{__dir__}/../files/#{n}.input")

test_input = '$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k'

input = test_input if ARGV.include?("test")

# ==========================================================

sizes = Hash.new(0)
path = []

input.split("\n").each do |command|
  case command
  when /\$ cd \.\./ then path.pop
  when /\$ cd (.*)/ then path << $1
  when /\$ ls/
  when /dir/
  # dir names can be fooking duplicate so hash key needs to be the whole path
  when /(\d+)/ then path.size.times { |i| sizes[path[0..i].join('/')] += $1.to_i }
  end
end

def part1(sizes)
  sizes.values.filter { |x| x < 100000 }.sum
end

def part2(sizes)
  sizes.values.sort.find { |x| 70000000 - sizes['/'] + x > 30000000 }
end

# ==========================================================

puts '='*20
puts 'part 1'
puts part1(sizes)

puts '='*20
puts 'part 2'
puts part2(sizes)
