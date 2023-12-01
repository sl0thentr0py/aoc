require 'pry'

input = File.read("#{__dir__}/../files/04.input")

# input = '7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

# 22 13 17 11  0
#  8  2 23  4 24
# 21  9 14 16  7
#  6 10  3 18  5
#  1 12 20 15 19

#  3 15  0  2 22
#  9 18 13 17  5
# 19  8  7 25 23
# 20 11 10 24  4
# 14 21 16 12  6

# 14 21 17 24  4
# 10 16 15  9 19
# 18  8 23 26 20
# 22 11 13  6  5
#  2  0 12  3  7'

class Cell
  attr_reader :num, :marked

  def initialize(num)
    @num, @marked = num, false
  end

  def mark!
    @marked = true
  end
end

class Board
  def initialize(input)
    @board = input.split("\n").map do |line|
      line.split.map(&:to_i).map { |x| Cell.new(x) }
    end
  end

  def mark!(num)
    @board.flatten.find { |c| c.num == num }&.mark!
  end

  # todo optimize
  def bingo?
    @board.any? { |row| row.all?(&:marked) } ||
      @board.transpose.any? { |col| col.all?(&:marked) }
  end

  def sum_unmarked
    @board.flatten.reject(&:marked).map(&:num).sum
  end
end

class Bingo
  def initialize(input)
    draw, *boards = input.split("\n\n")
    @draw = draw.split(',').map(&:to_i)
    @boards = boards.map { |b| Board.new(b) }
  end

  def run
    until winner = @boards.find(&:bingo?) do
      num = @draw.shift
      @boards.each { |b| b.mark!(num) }
    end

    num * winner.sum_unmarked
  end

  def run2
    until @boards.empty? || @draw.empty? do
      num = @draw.shift
      @boards.each { |b| b.mark!(num) }

      while index = @boards.find_index(&:bingo?) do
        winner = @boards.delete_at(index)
      end
    end

    num * winner.sum_unmarked
  end
end


def part1(input)
  bingo = Bingo.new(input)
  bingo.run
end

def part2(input)
  bingo = Bingo.new(input)
  bingo.run2
end

puts '='*20
puts 'part 1'
puts part1(input)

puts '='*20
puts 'part 2'
puts part2(input)
