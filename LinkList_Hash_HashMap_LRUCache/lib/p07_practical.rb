require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  map = HashMap.new(string.length)
  odd_sum = 0
  string.each_char do |chr|
    if map.include?(chr)
      val = map.get(chr) + 1
      map.set(chr, val)
    else
      map.set(chr, 1)
    end
  end
  map.each do | link |
    if link[1] % 2 != 0
      odd_sum += 1
    end
  end

  return false if odd_sum > 1
  true
end
