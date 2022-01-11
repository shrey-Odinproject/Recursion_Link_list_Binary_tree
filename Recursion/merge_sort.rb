def merge_sort(arr)
  if arr.length<2
    return arr
  end
  mid=arr.length/2
  left=arr[0...mid]
  right=arr[mid..]
  #print "#{left} | #{right} ."
  l=merge_sort(left)
  r=merge_sort(right)
  combine(l,r)
end

def combine(a,b)
  merged=[]
  a_i=0
  b_i=0
  while a_i<a.length && b_i<b.length
    if a[a_i]<b[b_i]
      merged.push(a[a_i])
      a_i+=1
    else
      merged.push(b[b_i])
      b_i+=1
    end 
  end
  merged+=a[a_i..]
  merged+=b[b_i..]
end

def merge(a,b)
  merged=[]
  while 
    if a[-1]<b[-1]
      merged.push(a.pop)
    else
      merged.push(b.pop)
    end 
  end
  merged+=a
  merged+=b
end
p merge_sort([6,4,1,3,2,5])