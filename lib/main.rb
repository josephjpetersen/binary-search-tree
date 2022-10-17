# frozen_string_literal: true

require_relative 'binary_search_tree'

test_array = (Array.new(15) { rand(1..100) })

binary_search_tree = Tree.new(test_array)

binary_search_tree.pretty_print

p 'Is the tree balanced?'
p binary_search_tree.balanced?

p 'Level Order Traversal'
p binary_search_tree.level_order

p 'Preorder Traversal'
p binary_search_tree.preorder

p 'Inorder Traversal'
p binary_search_tree.inorder

p 'Postorder Traversal'
p binary_search_tree.postorder

binary_search_tree.insert(123)
binary_search_tree.insert(156)
binary_search_tree.insert(101)
binary_search_tree.insert(193)
binary_search_tree.insert(113)

binary_search_tree.pretty_print

p 'Is the tree balanced?'
p binary_search_tree.balanced?

p 'Rebalancing Binary Search Tree...'
binary_search_tree.rebalance!

binary_search_tree.pretty_print

p 'Is the tree balanced?'
p binary_search_tree.balanced?

p 'Level Order Traversal'
p binary_search_tree.level_order

p 'Preorder Traversal'
p binary_search_tree.preorder

p 'Inorder Traversal'
p binary_search_tree.inorder

p 'Postorder Traversal'
p binary_search_tree.postorder
