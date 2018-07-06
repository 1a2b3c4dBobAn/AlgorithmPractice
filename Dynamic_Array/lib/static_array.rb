# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  def initialize(length)
    @store = []
    @capacity = length
  end

  # O(1)
  def [](index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  def length
    @store.length
  end

  def pop
    @store.pop
  end

  def shift
    @store.shift
  end

  def unshift(val)
    @store.unshift(val)
  end

  def max
    max = @store[0]
    @store.each do |el|
      max = el if !el.nil? && el > max
    end
    max
  end

  protected
  attr_accessor :store
end
