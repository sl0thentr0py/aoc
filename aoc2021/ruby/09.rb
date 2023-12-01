require 'pry'
require 'pry-nav'

input = File.read("#{__dir__}/../files/09.input")

# input = '2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678'

class Matrix
  attr_accessor :nrows, :ncols, :matrix

  def initialize(input)
    @matrix = input.split("\n").map { |r| r.chars.map(&:to_i) }
    @nrows = @matrix.size
    @ncols = @matrix.first.size
  end

  def lows
    find_lows.map { |i, j| matrix[i][j] }
  end

  def basins
    find_lows.map { |l| find_basin(*l) }
  end

  private

  # bfs
  def find_basin(lowi, lowj)
    queue = [[lowi, lowj]]
    basin = [[lowi, lowj]]

    until queue.empty? do
      visiti, visitj = queue.shift

      neighbors(visiti, visitj).each do |i, j|
        next if matrix[i][j] == 9
        next if basin.include?([i, j])
        basin << [i, j]
        queue << [i, j]
      end
    end

    basin
  end

  def find_lows
    lows = []

    nrows.times do |i|
      ncols.times do |j|
        lows << [i, j] if neighbors(i, j).all? { |i2, j2| matrix[i][j] < matrix[i2][j2] }
      end
    end

    lows
  end

  def neighbors(i, j)
    neighbors = []
    neighbors << [i - 1, j] if i > 0
    neighbors << [i + 1, j] if i < nrows - 1
    neighbors << [i, j - 1] if j > 0
    neighbors << [i, j + 1] if j < ncols - 1
    neighbors
  end
end

def part1(input)
  matrix = Matrix.new(input)
  matrix.lows.map { |l| l + 1 }.sum
end

def part2(input)
  matrix = Matrix.new(input)
  matrix.basins.map(&:size).sort.last(3).inject(:*)
end

puts '='*20
puts 'part 1'
puts part1(input)

puts '='*20
puts 'part 2'
puts part2(input)
