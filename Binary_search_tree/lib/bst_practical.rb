require 'binary_search_tree'

def kth_largest(tree_node, k)
  return tree_node.value if k == 0
  if tree_node.right
    kth_largest(tree_node.right, k-1)
  elsif tree_node.parent.left
    kth_largest(tree_node.parent.left, k-1)
  end
end
