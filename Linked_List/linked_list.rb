class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  def append(value)
    new = Node.new
    new.value(value)
    if !head
      self.head = new
    else
      pointer = head
      pointer = pointer.next while pointer.next
      pointer.next_node(new)
    end
  end

  def prepend(value)
    new = Node.new
    new.value(value)
    if !head
      self.head = new
    else
      new.next_node(head)
      self.head = new
    end
  end

  def size
    counter = 0
    pointer = head
    while pointer
      pointer = pointer.next
      counter += 1
    end
    counter
  end

  def tail
    pointer = head
    while pointer.next
      pointer = pointer.next
    end
    pointer
  end

  def at(idx)
    counter = 0
    pointer = head
    until counter == idx
      pointer = pointer.next
      counter += 1
    end
    pointer
  end

  def pop
    last = tail
    pointer = head
    until pointer.next == last
      pointer = pointer.next
    end
    pointer.next = nil
  end

  def contains?(value)
    pointer = head
    while pointer
      if pointer.val == value
        return true
      else
        pointer = pointer.next
      end
    end
    false
  end

  def find(value)
    pointer = head
    counter = 0
    while pointer
      if pointer.val == value
        return counter
      else
        pointer = pointer.next
        counter += 1
      end
    end
    nil
  end

  def to_s
    pointer = head
    str = ''
    while pointer
      str += " (#{pointer.val}) ->"
      pointer = pointer.next
    end
    str + ' nil'
  end

  def insert_at(value, idx)
    pointer = head
    counter = 0
    new = Node.new
    new.value(value)
    while pointer
      if counter == idx - 1
        new.next_node(pointer.next)
        pointer.next_node(new)
        return idx
      else
        pointer = pointer.next
        counter += 1
      end
    end
    'index out of range'
  end

  def remove_at(idx)
    
    if idx == 0
      n_node = head.next
      head.next = nil
      self.head = n_node
      return idx
    end
    
    pointer = head
    counter = 0
    while pointer
      if counter == idx - 1 && pointer.next
        n_node = pointer.next # n_node is next node (not the method)
        pointer.next = pointer.next.next
        n_node.next = nil
        return idx
      else
        pointer = pointer.next
        counter += 1
      end
    end
    'index out of range'
  end
end

class Node
  attr_accessor :val, :next

  def to_s
    "#{val}"
  end

  def initialize
    @val = nil
    @next = nil
  end

  def value(val)
    self.val = val
  end

  def next_node(node)
    self.next = node
  end
end

l_l = LinkedList.new
l_l.append(200)
l_l.append(132)
l_l.append(99)
l_l.prepend(707)
l_l.prepend(10)
l_l.insert_at(28, 3)

puts l_l

p l_l.remove_at(0)
puts l_l
