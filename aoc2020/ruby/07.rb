require 'pry'

# rules = "light red bags contain 1 bright white bag, 2 muted yellow bags.
# dark orange bags contain 3 bright white bags, 4 muted yellow bags.
# bright white bags contain 1 shiny gold bag.
# muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
# shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
# dark olive bags contain 3 faded blue bags, 4 dotted black bags.
# vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
# faded blue bags contain no other bags.
# dotted black bags contain no other bags.".lines.map(&:strip)

rules = File.readlines("#{__dir__}/../files/07.input").map(&:strip)

class DAG
  DEF_REGEX = /^(.*) bags contain (.*)\.$/
  CHILD_REGEX = /^(\d+|no) (.*) bags*$/

  Edge = Struct.new(:parent, :child, :num)

  def initialize(rules)
    @edges = rules.map do |rule|
      parent, children_def = rule.match(DEF_REGEX).captures

      children_def.split(', ').map do |child_def|
        num, child = child_def.match(CHILD_REGEX).captures
        Edge.new(parent, child, num.to_i) unless num == 'no'
      end.compact
    end.flatten
  end

  def all_parents(node)
    parents = @edges.select { |e| e.child == node }.map(&:parent)
    (parents + parents.map { |p| all_parents(p) }.compact.flatten).uniq
  end

  def weighted_children_sum(node)
    @edges.select { |e| e.parent == node }.
      map { |c| c.num * (1 + weighted_children_sum(c.child)) }.sum
  end
end

dag = DAG.new(rules)

puts '='*20
puts 'part 1'
puts dag.all_parents('shiny gold').size

puts '='*20
puts 'part 2'
puts dag.weighted_children_sum('shiny gold')
