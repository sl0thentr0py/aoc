require 'pry'

input = File.read("#{__dir__}/../files/05.input")

# input = '0,9 -> 5,9
# 8,0 -> 0,8
# 9,4 -> 3,4
# 2,2 -> 2,1
# 7,0 -> 7,4
# 6,4 -> 2,0
# 0,9 -> 2,9
# 3,4 -> 1,4
# 0,0 -> 8,8
# 5,5 -> 8,2'

class Grid
  attr_reader :grid

  def initialize
    @grid = Hash.new(0)
  end

  def process(line, diagonal: false)
    x1, y1, x2, y2 = parse(line)

    if x1 == x2
      asc_range(y1, y2).each { |y| @grid[[x1, y]] += 1 }
    elsif y1 == y2
      asc_range(x1, x2).each { |x| @grid[[x, y1]] += 1 }
    elsif diagonal
      diagonals(x1, y1, x2, y2).each { |x, y| @grid[[x, y]] += 1 }
    end
  end

  def num_intersect
    @grid.count { |_k, v| v > 1 }
  end

  private

  def asc_range(a, b)
    Range.new(*[a, b].sort)
  end

  def diagonals(x1, y1, x2, y2)
    xrange = x1 <= x2 ? x1.upto(x2) : x1.downto(x2)
    yrange = y1 <= y2 ? y1.upto(y2) : y1.downto(y2)
    xrange.zip(yrange)
  end

  def parse(line)
    line.match(/(\d+),(\d+) -> (\d+),(\d+)/).captures.map(&:to_i)
  end
end


def part1(input)
  grid = Grid.new
  input.split("\n").each { |line| grid.process(line) }
  grid.num_intersect
end

def part2(input)
  grid = Grid.new
  input.split("\n").each { |line| grid.process(line, diagonal: true) }
  grid.num_intersect
end

puts '='*20
puts 'part 1'
puts part1(input)

puts '='*20
puts 'part 2'
puts part2(input)
