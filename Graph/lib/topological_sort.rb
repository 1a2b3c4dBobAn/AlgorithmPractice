require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  queue = Queue.new
  list = []

  vertices.each do |vertex|
    queue.push(vertex) if vertex.in_edges.empty?
  end

  until queue.empty?
    node = queue.pop
    node.out_edges.dup.each do |edge|
      to_vertex = edge.to_vertex
      edge.destroy!
      queue.push(to_vertex) if to_vertex.in_edges.empty?
    end
    vertices.delete(node)
    list.push(node)
  end

  if vertices.length == 0
    list
  else
    return []
  end
end


# def topological_sort(vertices)
#   queue = Queue.new
#   list = []
#   in_edges_count = {}
#
#   vertices.each do |vertex|
#     in_edges_count[vertex] = vertex.in_edges.count
#     queue.push(vertex) if in_edges_count[vertex] == 0
#   end
#
#   until queue.empty?
#     node = queue.pop
#     node.out_edges.each do |edge|
#       to_vertex = edge.to_vertex
#       in_edges_count[to_vertex] -= 1
#       if in_edges_count[to_vertex] == 0
#         queue.push(to_vertex)
#       end
#       # edge.destroy!
#     end
#     # vertices.delete(node)
#     list.push(node)
#     # vertices.each do |vertex|
#     #   queue.push(vertex) if vertex.in_edges.empty?
#     # end
#   end
#
#   if vertices.length == list.length
#     list
#   else
#     return []
#   end
# end
