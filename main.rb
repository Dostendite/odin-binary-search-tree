require_relative "lib/node"
require_relative "lib/tree"

input_ary = [1, 2, 3, 3, 7, 15, 2, 0]

tree = Tree.new(input_ary)

puts "Printing tree..."
tree.pretty_print
puts

puts "Inserting nodes -> (-1), (6), (21), (-15)"
tree.insert(-1)
tree.insert(6)
tree.insert(21)
tree.insert(-15)
tree.insert(21)
tree.pretty_print
puts

puts "Deleting leaf node (21)"
tree.pretty_print
tree.delete(21)

puts "--------------------"
tree.pretty_print
puts

puts "Deleting parent of one node (7)"
tree.pretty_print
tree.delete(7)

puts "--------------------"
tree.pretty_print
puts

puts "Deleting parent of two node (0)"
tree.pretty_print
tree.delete(0)

puts "--------------------"
tree.pretty_print
puts

puts "Finding node (6)"
print "Final output: "
p tree.find(6)
puts

tree.pretty_print

puts "Traversing in level order..."
level_order_ary = tree.level_order
level_order_ary.each { |node| puts node.data }
puts

puts "Passing each value to a block..."
tree.level_order { |node| puts "I'm node #{node.data}, and times two I'm #{node.data * 2}!" }
puts

puts
puts "Traversing tree inorder..."
tree.inorder { |node| puts "I'm node -> #{node}!" }
puts

puts "Printing each value from the inorder output array..."
inorder_ary = tree.inorder
inorder_ary.each do |node|
  print "#{node.data} "
end
puts

puts
puts "Traversing tree preorder..."
tree.inorder { |node| puts "Node I am -> #{node}!" }
puts

puts "Printing each value from the preorder output array..."
preorder_ary = tree.preorder
preorder_ary.each do |node|
  print "#{node.data} "
end
puts

puts
puts "Traversing tree postorder..."
tree.inorder { |node| puts "I'm #{node} node!" }
puts

puts "Printing each value from the postorder output array..."
postorder_ary = tree.postorder
postorder_ary.each do |node|
  print "#{node.data} "
end
puts

puts "Inserting nodes -> (-3), (5), (8), (4)"
tree.insert(-3)
tree.insert(5)
tree.insert(8)
tree.insert(4)
tree.pretty_print
puts

puts "Getting height of node 2..."
puts tree.height(2)
puts "Getting height of node 7..."
puts tree.height(7)
puts "Getting height of node 3..."
puts tree.height(3)
puts

puts "Getting depth of node 8..."
puts tree.depth(8)
puts "Getting depth of node 2..."
puts tree.depth(2)
puts "Getting depth of node 1..."
puts tree.depth(1)

puts "Checking if the tree is balanced..."
p tree.balanced?
puts

puts "Balancing tree..."
tree.rebalance

puts "Checking if the tree is balanced..."
tree.pretty_print
p tree.balanced?
puts