class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]
    left = []
    array.each do |num|
      left << num if num < pivot
    end
    right =  array - left - [pivot]
    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return nil if length <= 1
    prc = prc || Proc.new {|num1, num2| num1 <=> num2}

    # start = rand(start + 1 ... start + length)
    idx  =  QuickSort.partition(array, start, length , &prc)

    QuickSort.sort2!(array, start, idx - start, &prc)
    QuickSort.sort2!(array, idx + 1, length - idx - 1, &prc)

  end

  def self.partition(array, start, length, &prc)
    return 0 if length == 0
    prc = prc || Proc.new {|num1, num2| num1 <=> num2}

    barrier = start

    (start + 1 ... start + length).each do |idx|
      if prc.call(array[start], array[idx]) > 0
        barrier += 1 #only work for towards right
        array[barrier], array[idx] = array[idx], array[barrier]
      end
    end

    array[start], array[barrier] = array[barrier], array[start]
    return barrier
  end

end
