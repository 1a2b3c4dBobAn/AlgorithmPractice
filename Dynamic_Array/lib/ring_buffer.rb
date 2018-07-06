require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @start_idx = 0
    @length = 0
  end


  # O(1)
  def [](index)
    raise 'index out of bounds' if index >= @length
    @store[(index + @start_idx) % @capacity]
  end

  # O(1)
  def []=(index, val)
    @store[index] = val
  end

  def max
    @store.max
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    last_idx = (@start_idx - 1 + @length) % @capacity
    last = @store[last_idx]
    @store[last_idx] = nil
    @length -= 1
    last
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    last_idx = (@start_idx + @length) % @capacity
    @length += 1
    @store[last_idx] = val
  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length == 0
    first = @store[@start_idx]
    @store[@start_idx] = nil
    @start_idx += 1
    @length -= 1
    first
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    if @start_idx > 0
      @start_idx -= 1
      @length += 1
      @store[@start_idx % @capacity] = val
    else
        @start_idx = @capacity - 1
        @store[@start_idx % @capacity] = val
        @length += 1
    end
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    capacity = @capacity * 2
    store = StaticArray.new(capacity)
    idx = @start_idx + @capacity
    count = 0
    until count == @length
      store[idx % capacity] = @store[(idx - @capacity) % @capacity]
      idx += 1
      count += 1
    end
    @start_idx = @start_idx + @capacity
    @capacity = capacity
    @store = store
  end
end
