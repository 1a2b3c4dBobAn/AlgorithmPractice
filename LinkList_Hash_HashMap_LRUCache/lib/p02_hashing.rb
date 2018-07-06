class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_num = 0
    self.each do |el|
      el.to_s.each_byte do |c|
        hash_num += (c * 3471 + hash_num * 0.66).round
      end
    end
    hash_num
  end
end

class String
  def hash
    hash_num = 0
    dup = self + self[0]
    dup.each_byte do |c|
      hash_num += c * 124763
    end
    hash_num
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_num = 0
    keys = self.keys
    keys.each_with_index do |key, idx|
      if idx.even?
        hash_num += self[key].to_s.hash
      else
        hash_num += key.to_s.hash
      end
    end
    hash_num
  end
end
