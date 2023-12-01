require 'pry'

class Asteroid
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def slope_to(a)
    Math.atan2(a.y - y, a.x - x)
  end

  def normalized_slope_to(a)
    slope = slope_to(a)
    # shift second quadrant to the end
    slope < (-Math::PI / 2) ? slope + 2 * Math::PI : slope
  end

  def normalized_distance
    x ** 2 + y ** 2
  end

  def distance_to(a)
    (a.y - y) ** 2 + (a.x - x) ** 2
  end
end

asteroids = File.readlines('input').map(&:strip).each_with_index.map do |line, y|
  line.chars.each_with_index.
    select { |c, x| c == '#' }.
    map { |c, x| Asteroid.new(x, y) }
end.flatten(1)

slopes = asteroids.map do |a1|
  asteroids.
    reject { |a2| a2 == a1 }.
    map { |a2| a1.slope_to(a2) }.
    uniq.size
end

count, index = slopes.each_with_index.max
p count
best = asteroids[index].dup
p best

###

base_station = asteroids.delete_at(index)

renormalized_asteroids = asteroids.map do |a|
  Asteroid.new(a.x - base_station.x, a.y - base_station.y)
end

base_station.x = 0
base_station.y = 0

foo = renormalized_asteroids.
    map { |a|  [base_station.normalized_slope_to(a), a] }.
    group_by(&:first).
    map { |k, v| [k, v.map(&:last).sort_by(&:normalized_distance)] }.
    sort_by(&:first)

count = 0
rotation = 0
key_index = 0

# binding.pry

while true
  count += 1 if foo[key_index][1][rotation]
  break if count == 200

  if key_index == foo.length - 1
    key_index = 0
    rotation += 1
  else
    key_index += 1
  end
end

asteroid = foo[key_index][1][rotation]
p asteroid.x + best.x
p asteroid.y + best.y
p 100 * (asteroid.x + best.x) + (asteroid.y + best.y)
