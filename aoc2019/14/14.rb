require 'pry'
require 'tsort'

class DAG
  include TSort

  Node = Struct.new(:name, :quantity)
  Edge = Struct.new(:from, :to, :weight)

  def initialize(input)
    @nodes = []
    @edges = []

    input.each do |line|
      requirements, product = line.split(' => ')

      quantity, to_name = product.match(/(\d+)\ (.*)/).captures
      @nodes << Node.new(to_name, quantity.to_i)

      requirements.split(', ').each do |requirement|
        weight, from_name = requirement.match(/(\d+)\ (.*)/).captures
        @edges << Edge.new(from_name, to_name, weight.to_i)
      end
    end
  end

  def tsort_each_node(&block)
    @nodes.map(&:name).each(&block)
  end

  def tsort_each_child(node, &block)
    @edges.select { |e| e.from == node }.map(&:to).each(&block)
  end

  def incoming(node)
    @edges.select { |e| e.to == node }
  end

  def requirements(name, quantity)
    node = @nodes.find { |n| n.name == name }
    raise unless node
    multiplier = (quantity * 1.0 / node.quantity).ceil

    incoming(name).map do |edge|
      [edge.from, edge.weight * multiplier]
    end.to_h
  end
end

input = File.readlines('input', chomp: true)
graph = DAG.new(input)

def ore(graph, fuel)
  materials = { 'FUEL' => fuel }

  graph.tsort.each do |name|
    quantity = materials.delete(name)
    new_materials = graph.requirements(name, quantity)
    materials.merge!(new_materials) { |k, v1, v2| v1 + v2 }
  end

  materials['ORE']
end

pp ore(graph, 1)

####
lb = 1
ub = 20000000000 # random
fuel = (lb..ub).bsearch { |x| ore(graph, x) > 1000000000000 } - 1
pp fuel
pp ore(graph, fuel)
