class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |parent, child| parent <=> child }
  end

  def count
    @store.count
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    extracted = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count, &@prc)
    extracted
  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count-1, &@prc)
  end

  public
  def self.child_indices(len, parent_idx)
    child_indices = []
    child_indices << parent_idx * 2 + 1 if parent_idx * 2 + 1 < len
    child_indices << parent_idx * 2 + 2 if parent_idx * 2 + 2 < len
    child_indices
  end

  def self.parent_index(child_index)
    return (child_index - 1) / 2 if (child_index - 1) / 2 >= 0
    raise 'root has no parent'
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    child_indices = BinaryMinHeap.child_indices(len, parent_idx)
    prc = prc || Proc.new { |parent, child| parent <=> child }

    if child_indices.length > 1 && prc.call(array[child_indices[0]], array[child_indices[1]]) >= 0
      child_indices[0], child_indices[1] = child_indices[1], child_indices[0]
    end

    if child_indices.length > 0 && prc.call(array[parent_idx], array[child_indices[0]]) >= 0
      array[child_indices[0]], array[parent_idx] = array[parent_idx], array[child_indices[0]]
      BinaryMinHeap.heapify_down(array, child_indices[0], len = array.length, &prc)
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc = prc || Proc.new { |parent, child | parent <=> child }

    return array if child_idx == 0
    parent_idx = BinaryMinHeap.parent_index(child_idx)
    if prc.call(array[parent_idx], array[child_idx]) >= 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      BinaryMinHeap.heapify_up(array, parent_idx, len = array.length, &prc) if parent_idx != 0
    end
    array
  end

end
