require 'pry'

NUM = File.basename($0).scan(/\d+/).first
input = File.read("#{__dir__}/../files/#{NUM}.input")

# input = '5483143223
# 2745854711
# 5264556173
# 6141336146
# 6357385478
# 4167524645
# 2176841721
# 6882881134
# 4846848554
# 5283751526
# '

class Matrix
  attr_reader :flashes

  def initialize(input)
    @matrix = input.split("\n").map { |r| r.chars.map(&:to_i) }
    @nrows = @matrix.size
    @ncols = @matrix.first.size
    @flashes = 0
  end

  def simulate(steps)
    return if steps == 0
    run_step
    simulate(steps - 1)
  end

  def find_sync
    steps = 0

    until sync?
      run_step
      steps += 1
    end

    steps
  end

  private

  def sync?
    @matrix.all? { |r| r.all? { |x| x == 0 } }
  end

  def run_step
    @flashed = []
    @nrows.times { |i| @ncols.times { |j| @matrix[i][j] += 1 } }

    while flasher = find_flasher do
      i, j = flasher
      @flashed << flasher
      @matrix[i][j] = 0
      # binding.pry

      neighbors(i, j).each do |x, y|
        next if @flashed.include?([x, y])
        @matrix[x][y] += 1
      end
    end

    @flashes += @flashed.size
  end

  def find_flasher
    i, j = nil, nil
    i = @matrix.find_index { |r| j = r.find_index { |x| x > 9 } }
    return nil if i.nil? || j.nil?
    [i, j]
  end

  def neighbors(i, j)
    [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1], [0, 1],
      [1, -1], [1, 0], [1, 1]
    ].map { |x, y| [i + x, j + y] }.
      reject { |x, y| x < 0 || x >= @nrows || y < 0 || y >= @ncols }
  end
end

def part1(input)
  matrix = Matrix.new(input)
  matrix.simulate(100)
  matrix.flashes
end

def part2(input)
  matrix = Matrix.new(input)
  matrix.find_sync
end

puts '='*20
puts 'part 1'
puts part1(input)

puts '='*20
puts 'part 2'
puts part2(input)
