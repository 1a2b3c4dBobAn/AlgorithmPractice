class BSTNode
  attr_reader :value
  attr_accessor :left, :right, :parent

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @parent = nil
  end

  def set(value)
    new_node = BSTNode.new(value)
    case self.value <=> value
    when 1 || 0
      if self.left
        self.left.set(value)
      else
        self.left = new_node
        new_node.parent = self
      end
    when -1
      if self.right
        self.right.set(value)
      else
        self.right = new_node
        new_node.parent = self
      end
    end
  end

  def find(value)
    case self.value <=> value
    when -1
      self.right ? self.right.find(value) : nil
    when 0
      return self
    when 1
      self.left ? self.left.find(value) : nil
    end
  end
  
end
