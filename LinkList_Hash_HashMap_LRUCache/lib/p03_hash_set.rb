require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    @count += 1
    num = key.hash
    bucket = self[num]
    bucket.push(key)
  end

  def include?(key)
    num = key.hash
    bucket = self[num]
    bucket.include?(key)
  end

  def remove(key)
    resize! if @count == num_buckets
    @count -= 1
    num = key.hash
    bucket = self[num]
    bucket.delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    pre_store = @store
    @store = Array.new(num_buckets * 2) {Array.new}
    @count = 0
    pre_store.each do |bucket|
      if bucket != []
        bucket.each {|key| insert(key)}
      end
    end
  end
end
