require_relative "heap"

class Array
  def heap_sort!

    prc = Proc.new { |parent, child| child <=> parent }


    self.each_index do |idx|
      self[0..idx] = BinaryMinHeap.heapify_up(self[0..idx], idx, self[0..idx].length, &prc)
    end

    idx = self.length - 1
    while idx > 0
      self[0], self[idx] = self[idx], self[0]
      self[0...idx] = BinaryMinHeap.heapify_down(self[0...idx], 0, self[0...idx].length, &prc)
      idx -= 1
    end
    self
  end
end
