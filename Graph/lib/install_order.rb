# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require 'set'
require_relative 'graph'
require_relative 'topological_sort'

def install_order(arr)
  vertices = to_graph(arr)
  result = topological_sort(vertices)
  result.map {|vertex| vertex.value}
end

def to_graph(arr)
  # keep track of max_id
  max_id = 0
  vertices = Set.new
  vertices_hash = {}
  arr.each do |tuple|

  # create the vertices and also the related edges
    to_vertex =  vertices_hash[tuple[0]] || Vertex.new(tuple[0])
    from_vertex = vertices_hash[tuple[1]] || Vertex.new(tuple[1])
    edge = Edge.new(from_vertex, to_vertex)
    # debugger
    vertices << from_vertex
    vertices << to_vertex

    # record the tuple in hash and update the max_id
    vertices_hash[tuple[0]] = to_vertex
    vertices_hash[tuple[1]] = from_vertex

    tuple.each do |id|
      max_id = id if id > max_id
    end
  end

  # insert the vertices who have no dependencies
  (0..max_id).each do |id|
    vertices << Vertex.new(id) if !vertices_hash[id]
  end

  # return vertices
  vertices
end
