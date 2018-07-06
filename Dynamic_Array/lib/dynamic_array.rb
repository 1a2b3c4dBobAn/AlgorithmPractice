require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
  end

  def length
    @store.length
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index >= length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0
    @store.pop
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize if length == @capacity
    @store[length] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if length == 0
    first = @store[0]
    @store.shift
    first
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if length == @capacity
      @capacity = @capacity * 2
    end
    store = StaticArray.new(@capacity)
    store[0] = val
    idx = 1
    while idx <= length
      store[idx] = @store[idx - 1]
      idx += 1
    end
    @store = store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize
    @capacity = @capacity * 2
    store = StaticArray.new(@capacity)
    idx = 0
    while idx < length
      store[idx] = @store[idx]
      idx += 1
    end
    @store = store
  end
end
