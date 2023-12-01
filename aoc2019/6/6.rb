$orbits = File.readlines('input').map { |line| line.strip.split(')').reverse }.to_h

def parents(planet)
  return [] unless $orbits[planet]
  parents($orbits[planet]) << $orbits[planet]
end

p $orbits.keys.map { |p| parents(p).length }.sum

#####

p1 = parents('YOU').reverse
p2 = parents('SAN').reverse

least_common_ancestor = (p1 & p2).first

i1 = p1.index(least_common_ancestor)
i2 = p2.index(least_common_ancestor)

p i1 + i2

