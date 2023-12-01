Vector = Struct.new(:x, :y, :z)

Moon = Struct.new(:position, :velocity) do
  %w(x y z).each do |axis|
    define_method "apply_gravity_#{axis}" do |m|
      diff = m.position.send(axis) - self.position.send(axis)
      new_vel = self.velocity.send(axis) + (diff <=> 0)
      self.velocity.send("#{axis}=", new_vel)
    end

    define_method "apply_velocity_#{axis}" do
      new_pos = self.position.send(axis) + self.velocity.send(axis)
      self.position.send("#{axis}=", new_pos)
    end
  end

  def apply_gravity(m)
    %w(x y z).each do |axis|
      self.send("apply_gravity_#{axis}", m)
    end
  end

  def apply_velocity
    %w(x y z).each do |axis|
      self.send("apply_velocity_#{axis}")
    end
  end

  def pe
    position.x.abs + position.y.abs + position.z.abs
  end

  def ke
    velocity.x.abs + velocity.y.abs + velocity.z.abs
  end

  def te
    pe * ke
  end
end

class Simulation
  attr_accessor :moons

  def initialize(input)
    @moons = input.map do |line|
      x, y, z = line.match(/.*x=(-?\d+).*y=(-?\d+).*z=(-?\d+)/).captures.map(&:to_i)

      position = Vector.new(x, y, z)
      velocity = Vector.new(0, 0, 0)

      Moon.new(position, velocity)
    end
  end

  def step
    @moons.combination(2).each do |m1, m2|
      m1.apply_gravity(m2)
      m2.apply_gravity(m1)
    end

    @moons.each(&:apply_velocity)
  end

  def step_axis(axis)
    @moons.combination(2).each do |m1, m2|
      m1.send("apply_gravity_#{axis}", m2)
      m2.send("apply_gravity_#{axis}", m1)
    end

    @moons.each { |m| m.send("apply_velocity_#{axis}") }
  end

  def energy
    @moons.map(&:te).sum
  end

  def run(n)
    n.times { step }
  end

  def state(axis)
    @moons.map do |m|
      [m.position.send(axis), m.velocity.send(axis)]
    end.flatten
  end

  def run_till_equal(axis)
    initial_state = state(axis)
    steps = 0

    until state(axis) == initial_state && steps > 0
      step_axis(axis)
      steps += 1
    end

    steps
  end

  def run_till_equal_all
    %w(x y z).map { |axis| run_till_equal(axis) }.
      inject(1, :lcm)
  end

end

input = File.readlines('input', chomp: true)
s = Simulation.new(input)
s.run(1000)
p s.energy

p "-------"

s = Simulation.new(input)
p s.run_till_equal_all
