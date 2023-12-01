module Constants
  NORTH, SOUTH, EAST, WEST, LEFT, RIGHT, FORWARD = %w(N S E W L R F)

  DIRECTION_MAP = { 0 => EAST, 90 => NORTH, 180 => WEST, 270 => SOUTH }
end

class Ship
  include Constants

  def initialize
    @x, @y, @direction = 0, 0, 0
  end

  def execute(instructions)
    instructions.each do |instruction|
      operation, number = instruction[0], instruction[1..-1].to_i

      case operation
      when LEFT then @direction = (@direction + number) % 360
      when RIGHT then @direction = (@direction - number) % 360
      when FORWARD then move(DIRECTION_MAP[@direction], number)
      else move(operation, number)
      end
    end

    @x.abs + @y.abs
  end

  def move(dir, distance)
    case dir
    when NORTH then @y += distance
    when SOUTH then @y -= distance
    when EAST then @x += distance
    when WEST then @x -= distance
    end
  end
end

class WaypointShip
  include Constants

  def initialize
    @x, @y = 0, 0
    @wx, @wy = 10, 1
  end

  def execute(instructions)
    instructions.each do |instruction|
      operation, number = instruction[0], instruction[1..-1].to_i

      case operation
      when NORTH then @wy += number
      when SOUTH then @wy -= number
      when EAST then @wx += number
      when WEST then @wx -= number
      when LEFT then turn_waypoint(number)
      when RIGHT then turn_waypoint(-number)
      when FORWARD then move(number)
      end
    end

    @x.abs + @y.abs
  end

  def move(steps)
    @x += steps * @wx
    @y += steps * @wy
  end

  def turn_waypoint(angle)
    @wx, @wy = @wx * cos(angle) - @wy * sin(angle), @wx * sin(angle) + @wy * cos(angle)
  end

  def cos(angle)
    case angle % 360
    when 0 then 1
    when 90 then 0
    when 180 then -1
    when 270 then 0
    end
  end

  def sin(angle)
    cos(90 - angle)
  end

end

input = File.readlines("#{__dir__}/../files/12.input").map(&:strip)

puts '='*20
puts 'part 1'
puts Ship.new.execute(input)

puts '='*20
puts 'part 2'
puts WaypointShip.new.execute(input)
