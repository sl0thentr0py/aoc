#require 'pry'
#input = "..##.......
##...#...#..
#.#....#..#.
#..#.#...#.#
#.#...##..#.
#..#.##.....
#.#.#.#....#
#.#........#
##.##...#...
##...##....#
#.#..#...#.#".lines.map(&:strip)

input = File.readlines("#{__dir__}/../files/03.input").map(&:strip)

class Map
  def initialize(input)
    @map = input
    @X = input.first.length
    @Y = input.length
  end

  def count_trees(sx, sy)
    (0...(@Y / sy)).count { |i| @map[sy * i][sx*i % @X] == '#' }
  end
end

map = Map.new(input)

puts '='*20
puts 'part 1'
puts map.count_trees(1, 2)

puts '='*20
puts 'part 2'
puts [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].
  map { |sx, sy| map.count_trees(sx, sy) }.
  inject(1, :*)
