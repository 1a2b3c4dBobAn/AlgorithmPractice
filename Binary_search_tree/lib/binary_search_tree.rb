# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require "bst_node"

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    node = BSTNode.new(value)
    if @root.nil?
      @root = node
    else
      @root.set(value)
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    tree_node.find(value)
  end

  def delete(value)
    # step 1 :find the target node
    node = find(value)
    return nil if node.nil?
    if node == root
      @root = nil
      return root
    end
    parent = node.parent
    case parent.value <=> value
    when 1 || 0
      onleft = true
    when -1
      onleft = false
    end
    if node.left || node.right
      # step 3a: if node has only one child
      if !!node.left ^ !!node.right
        child = node.left || node.right
      # step 3b: if node has two children
      elsif node.left && node.right
        child = maximum(node.left)
        if child.left || child.right
          delete(child.value)
        end
        child.right = node.right
        child.left = node.left if child != node.left
      end
      child.parent = parent
    else
      # step 2: if node has no children, erase node
      child = nil
    end
    if onleft
      parent.left = child
    else
      parent.right = child
    end
    node.parent = nil
  end


  # helper method for #delete:
  def maximum(tree_node = @root)
    right = tree_node.right
    return tree_node if right.nil?
    right.right ? maximum(right) : right
  end

  def depth(tree_node = @root)
    return -1 if tree_node.nil?
    left = depth(tree_node.left)
    right = depth(tree_node.right)
    [left, right].max + 1
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    left_depth = depth(tree_node.left)
    right_depth = depth(tree_node.right)
    if (left_depth - right_depth).abs > 1
      return false
    else
      is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
    end
  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr.push(tree_node.value)
    in_order_traversal(tree_node.right, arr) if tree_node.right
    arr
  end


  private
  # optional helper methods go here:

end
