require_relative 'heap'

def k_largest_elements(array, k)
  prc = Proc.new { |parent, child| child <=> parent }

  len = array.length
  array.each_index do |idx|
    array[0..idx] = BinaryMinHeap.heapify_up(array[0..idx], idx, array[0..idx].length, &prc)
  end

  idx = len - 1
  count = 0

  while idx > 0
    array[0], array[idx] = array[idx], array[0]
    array[0...idx] = BinaryMinHeap.heapify_down(array[0...idx], 0, array[0...idx].length, &prc)
    idx -= 1
    count += 1
    break if count == k
  end

  array [len-k..-1]
end
