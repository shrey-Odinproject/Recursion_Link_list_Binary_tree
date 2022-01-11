def fibs_iter(n,arr=[])
  if n==0
    arr=[0]
  elsif n==1
    arr=[0,1]
  else
    arr=[0,1]
    i=2
    while i<=n
      next_num=arr[-1]+arr[-2]
      arr.push(next_num)
      i+=1
    end
  end
  arr
end

def fibs_recur(n,arr=[])
  if n==0
    return [0]
  elsif n==1
    return [0,1]
  end
  arr=fibs_recur(n-1)
  arr.push(arr[-1]+arr[-2])
end

p fibs_iter(10)
p fibs_recur(10)