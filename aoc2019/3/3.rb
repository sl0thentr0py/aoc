wire1, wire2 = File.readlines('input').map(&:strip).map { |x| x.split(',') }

class Point
  attr_accessor :x, :y, :steps

  def initialize(x, y, steps=nil)
    @x = x
    @y = y
    @steps = steps
  end

  def manhattan
    x.abs + y.abs
  end

  def eql?(b)
    x == b.x && y == b.y
  end

  def ==(b)
    eql?(b)
  end

  def hash
    [x , y].hash
  end
end

def points(wire)
  points = []
  x = 0
  y = 0
  total_steps = 0

  wire.each do |code|
    direction = code[0]
    steps = code[1..-1].to_i

    case direction
    when "L"
      points += (1..steps).map { |s| Point.new(x - s, y, total_steps += 1) }
      x -= steps
    when "R"
      points += (1..steps).map { |s| Point.new(x + s, y, total_steps += 1) }
      x += steps
    when "U"
      points += (1..steps).map { |s| Point.new(x, y + s, total_steps += 1) }
      y += steps
    when "D"
      points += (1..steps).map { |s| Point.new(x, y - s, total_steps += 1) }
      y -= steps
    end
  end

  points
end

p1s = points(wire1)
p2s = points(wire2)

intersection = p1s & p2s
p intersection.map(&:manhattan).min

####
## hacky but lazy

p1_steps_hash = p1s.map { |p| [p, p.steps] }.to_h
p2_steps_hash = p2s.map { |p| [p, p.steps] }.to_h

intersection.each do |i|
  i.steps = p1_steps_hash[i] + p2_steps_hash[i]
end

p intersection.map(&:steps).min
