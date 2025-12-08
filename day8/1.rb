require 'set'

filepath = ARGV[0]

puts "reading from #{filepath}"

nodes = []
missing_edges = []

File.open(filepath).each_line do |line|
  node = line.rstrip.split(",").map(&:to_i)
  nodes << node
end

nodes.each_with_index do |node, i|
  nodes.each_with_index do |node2, j|
    next if node.to_s >= node2.to_s
    missing_edges << [node, node2]
  end
end

missing_edges.sort_by! do |n1, n2|
  (n2[0]-n1[0])**2 + (n2[1]-n1[1])**2 + (n2[2]-n1[2])**2
end.reverse

puts "collected and sorted #{missing_edges.count} missing_edges"

component_by_node = nodes.reduce({}) do |acc, node|
  acc.merge({node => Set.new([node])})
end

1000.times do |i|
  edge = missing_edges.shift
  # puts "edge: #{edge}"
  node0 = edge[0]
  node1 = edge[1]
  component0 = component_by_node[node0]
  component1 = component_by_node[node1]
  # puts "#{component0}, #{component1}"
  merged_component = component0.union(component1)
  merged_component.each do |node|
    component_by_node[node] = merged_component
  end
end

components = component_by_node.values.uniq.sort_by(&:length).reverse

puts "component count: #{components.count}"
n = 3
puts "first #{n}: #{components.first(n)}"
puts "product of size of first #{n}: #{components.first(n).map(&:length).reduce(:*)}}"
