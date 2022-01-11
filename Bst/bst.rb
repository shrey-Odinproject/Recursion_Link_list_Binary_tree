# a tree node
=begin
  def insert_complex(val, pointer=root)
    if pointer.data==val
      return nil
    elsif pointer.data>val
      if pointer.left
        insert(val,pointer.left)
      else
        pointer.left=Node.new(val)
      end 
    elsif pointer.data<val
      if pointer.right
        insert(val,pointer.right)
      else
        pointer.right=Node.new(val)
      end 
    end
  end
  def next_biggest_complex(node)
    next_biggest_node=node.right
    next_biggest_node_parent=node.right
    
    while next_biggest_node.left
      next_biggest_node=next_biggest_node.left
      if  next_biggest_node.left.left
        next_biggest_node_parent=next_biggest_node.left
      end
    end
    #next_biggest_node_parent=next_biggest_node.left while  next_biggest_node.left.left
    #next_biggest_node=next_biggest_node.left while next_biggest_node.left
    [next_biggest_node,next_biggest_node_parent]
  end
  
  def delete_complex(val,pointer=root)
    #binding.pry
    # special case to remove root needed
    return puts 'val not in tree' if pointer==nil
    left_child=pointer.left 
    right_child=pointer.right 
    
    if left_child && left_child.data==val
      if is_leaf?(left_child)
        pointer.left=nil
        return val
      elsif has_single_child?(left_child)
        pointer.left=(left_child.left || left_child.right)
        left_child.left,left_child.right=nil,nil
        return val
      elsif has_both_child?(left_child)
        replacement,replacement_parent=next_biggest_complex(left_child)
        replacement_parent.left= replacement.right# replacement has no lst
        
        pointer.left=replacement
        replacement.left=left_child.left
        replacement.right=left_child.right
        left_child.left,left_child.right=nil,nil
        return val
      end
    
    elsif right_child && right_child.data==val
      if is_leaf?(right_child)
        pointer.right=nil
        return val
      elsif has_single_child?(right_child)
        pointer.right=(right_child.left || right_child.right)
        left_child.left,left_child.right=nil,nil
        return val
      elsif has_both_child?(right_child)
        replacement,replacement_parent=next_biggest_complex(right_child)
        replacement_parent.left= replacement.right# replacement has no lst
        
        pointer.right=replacement
        replacement.left=right_child.left
        replacement.right=right_child.right
        right_child.left,right_child.right=nil,nil
        return val
      end
    
    elsif pointer.data>val
      delete(val,pointer.left)
    
    elsif pointer.data<val
      delete(val,pointer.right)
    end  
  end
=end

class Node
  #include Comparable
  #attr :data
  #def <=>(other_node)
  #  data <=> other_node.data
  #end

  attr_accessor :data, :left, :right

  def initialize(data=nil)
    @data = data
    @left = nil
    @right = nil
  end
  def to_s
    "#{data}"
  end
end

class Tree
  attr_accessor :t_array, :root
  
  def initialize(init_arr)
    @t_array=init_arr.sort!.uniq!
    @root=build_tree(t_array)
  end

  def build_tree(array)
    return nil if array.length<1
    
    mid_idx=array.length/2
    mid_elm=array[mid_idx]
    
    left_s_array=array[0...mid_idx]
    right_s_array=array[mid_idx+1...]

    node=Node.new(mid_elm)
    node.left=build_tree(left_s_array)
    node.right=build_tree(right_s_array)
    return node
  end
  
  def insert(val,pointer=root) # took help frm additional resources
    if pointer==nil
      return Node.new(val)
    end

    if pointer.data<val
      pointer.right=insert(val,pointer.right)
    elsif pointer.data>val
      pointer.left=insert(val,pointer.left)
    end
    pointer
  end
  
  def is_leaf?(node)
    if node.left==nil && node.right==nil
      true
    else
      false
    end
  end

  def has_single_child?(node)
    if (node.left && !node.right) || (!node.left && node.right)
      true
    else
      false
    end
  end

  def has_both_child?(node)
    if node.left && node.right
      true
    else
      false
    end
  end

  def delete(val,pointer=root)
    
    if pointer==nil
      return pointer
    end
    if pointer.data<val
      pointer.right=delete(val,pointer.right)
    elsif pointer.data>val
      pointer.left=delete(val,pointer.left)
    
    else
      if is_leaf?(pointer)
        pointer=nil
      elsif has_single_child?(pointer)
        pointer.left ? temp=pointer.left : temp=pointer.right
        pointer=nil
        return temp
      elsif has_both_child?(pointer)
        temp=successor(pointer.right)
        pointer.data=temp.data # transfer data
        pointer.right=delete(temp.data,pointer.right) # remove successor from old spot , its either a leaf or has 1 child 
        # jo bhi hoga case uss hisab se recursion ho jaega
      end
    end
    pointer
  end

  def successor(node)
    current=node
    current=current.left while current.left #finds lefmost leaf
    current
  end

  def find(value,pointer=root)
    if pointer==nil
      return pointer
    end
    if pointer.data<value
      find(value,pointer.right)
    elsif pointer.data>value
      find(value,pointer.left)
    else
      return pointer
    end
  end
  
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def level_order_iter
    queue=[root]
    ans=[]
    until queue.empty?
      current=queue.shift
      if block_given?
        yield(current.data)
      else
        ans.push(current.data)
      end
      queue.push(current.left) if current.left
      
      queue.push(current.right) if current.right
    end
    ans
  end

  def level_order_recur(queue=[root],ans=[],&block)
    current=queue.shift
    
    if current==nil
      return current
    end
    
    if block_given?
      block.call(current.data)
    else
      ans.push(current.data)
    end
    queue.push(current.left) if current.left
    queue.push(current.right) if current.right
    level_order_recur(queue,ans,&block)
    return ans
  end

  def inorder(pointer=root,arr=[],&block)
    if pointer==nil
      return pointer
    end
    inorder(pointer.left,arr,&block)
    if block_given?
      block.call(pointer.data)
    else
      arr.push(pointer.data)
    end
    inorder(pointer.right,arr,&block)
    arr
  end

  def preorder(pointer=root,arr=[],&block)
    if pointer==nil
      return pointer
    end
    if block_given?
      block.call(pointer.data)
    else
      arr.push(pointer.data)
    end
    preorder(pointer.left,arr,&block)
    preorder(pointer.right,arr,&block)
    arr
  end

  def postorder(pointer=root,arr=[],&block)
    if pointer==nil
      return pointer
    end
    postorder(pointer.left,arr,&block)
    postorder(pointer.right,arr,&block)
    if block_given?
      block.call(pointer.data)
    else
      arr.push(pointer.data)
    end
    arr
  end

  def height(node)
    if is_leaf?(node)
      return 0
    end
    left=height(node.left) if node.left
    right=height(node.right) if node.right
    count=[left.to_i,right.to_i].max
    count+=1
  end

  def depth(node)
   max=height(root)
   return max-height(node)
  end

  def balanced?(pointer=root)
    if is_leaf?(pointer)
      return true
    end
    diff=(height(pointer.left)-height(pointer.right)).abs
    diff<=1 ? true : false
  end
  
  def rebalance
    self.root=build_tree(inorder)
  end
end

