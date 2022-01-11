require './bst.rb'
def print_orders(bst)
  p bst.level_order_recur
  puts '++++++++++++++++'
  p bst.preorder
  puts '++++++++++++++++'
  p bst.inorder
  puts '++++++++++++++++'
  p bst.postorder
end
bst=Tree.new (Array.new(15) { rand(1..100) })

p bst.balanced?

print_orders(bst)

Array.new(150) { rand(1..10000) }.each do |num|
  bst.insert(num)
end

p bst.balanced?

bst.rebalance

p bst.balanced?

print_orders(bst)