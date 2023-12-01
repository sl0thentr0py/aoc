class Grid
  attr_accessor :grid

  DIRECTIONS = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]

  def initialize(grid)
    @grid = grid
  end

  def ==(g)
    g.class == self.class && g.grid == self.grid
  end

  def in_grid?(x, y)
    x >= 0 && x < grid.length && y >= 0 && y < grid.first.length
  end

  def fetch(x, y)
    return nil unless in_grid?(x, y)
    grid[x][y]
  end

  def occupied_neighbours(i, j)
    DIRECTIONS.count { |x, y| fetch(i + x, j + y) == '#' }
  end

  def occupied_visible(i, j)
    DIRECTIONS.count do |x, y|
      x2, y2 = i + x, j + y
      x2, y2 = x2 + x, y2 + y while fetch(x2, y2) == '.'
      fetch(x2, y2) == '#'
    end
  end

  def transform(scope:, threshold:)
    Grid.new(
      grid.map.with_index do |row, i|
        row.map.with_index do |cell, j|
          occupied_count = send("occupied_#{scope}", i, j)

          case cell
          when '.' then '.'
          when '#' then occupied_count >= threshold ? 'L' : '#'
          when 'L' then occupied_count == 0 ? '#' : 'L'
          end
        end
      end
    )
  end

  def self.steady_state_oc(input, part: 1)
    opts = part == 1 ? { scope: :neighbours, threshold: 4 } : { scope: :visible, threshold: 5 }

    g = Grid.new(input)
    g2 = g.transform(**opts)

    g, g2 = g2, g2.transform(opts) until g2 == g
    g.grid.flatten.count('#')
  end
end

input = File.readlines("#{__dir__}/../files/11.input").map(&:chars)

puts '='*20
puts 'part 1'
puts Grid.steady_state_oc(input)

puts '='*20
puts 'part 2'
puts Grid.steady_state_oc(input, part: 2)
