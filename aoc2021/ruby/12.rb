require 'pry'
require 'pry-nav'

NUM = File.basename($0).scan(/\d+/).first
input = File.read("#{__dir__}/../files/#{NUM}.input")

# input = 'start-A
# start-b
# A-c
# A-b
# b-d
# A-end
# b-end'

class Graph
  attr_accessor :paths

  def initialize(input)
    @paths = []
    @neighbors = {}

    input.split("\n").each do |line|
      a, b = line.split('-')

      unless b == 'start' || a == 'end'
        @neighbors[a] ||= []
        @neighbors[a] << b
      end

      unless a == 'start' || b == 'end'
        @neighbors[b] ||= []
        @neighbors[b] << a
      end
    end
  end

  def dfs(current: 'start', path: ['start'], part2: false)
    if current == 'end'
      @paths << path
    else
      @neighbors[current].each do |neighbor|
        lower_seen = lower?(neighbor) && path.include?(neighbor)
        next if !part2 && lower_seen
        dfs(current: neighbor, path: path + [neighbor], part2: part2 && !lower_seen)
      end
    end
  end

  private

  def lower?(n)
    n =~ /[[:lower:]]/
  end
end

def part1(input)
  g = Graph.new(input)
  g.dfs
  g.paths.size
end

def part2(input)
  g = Graph.new(input)
  g.dfs(part2: true)
  g.paths.size
end

puts '='*20
puts 'part 1'
puts part1(input)

puts '='*20
puts 'part 2'
puts part2(input)
