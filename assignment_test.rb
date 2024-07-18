require_relative "lib/node"
require_relative "lib/tree"

puts "Spawning tree..."
yggdrasil = Tree.new(Array.new(15) { rand(1..100) })

puts "Printing tree..."
yggdrasil.pretty_print
puts

puts "Is the tree balanced?"
puts yggdrasil.balanced?
puts

puts "Traversing tree in level order..."
yggdrasil.level_order { |node| print "#{node.data} " }
puts

puts "Traversing tree preorder..."
yggdrasil.preorder { |node| print "#{node.data} " }
puts

puts "Traversing tree postorder..."
yggdrasil.postorder { |node| print "#{node.data} " }
puts

puts "Traversing tree inorder..."
yggdrasil.inorder { |node| print "#{node.data} " }
puts

puts "Unbalancing the tree..."
yggdrasil.insert(112)
yggdrasil.insert(145)
yggdrasil.insert(122)
yggdrasil.insert(128)
yggdrasil.insert(105)
yggdrasil.pretty_print
p yggdrasil.balanced?
puts

puts "Rebalancing the treee..."
yggdrasil.rebalance
yggdrasil.pretty_print
p yggdrasil.balanced?
puts

puts "Traversing tree preorder..."
yggdrasil.preorder { |node| print "#{node.data} " }
puts

puts "Traversing tree postorder..."
yggdrasil.postorder { |node| print "#{node.data} " }
puts

puts "Traversing tree inorder..."
yggdrasil.inorder { |node| print "#{node.data} " }
puts
