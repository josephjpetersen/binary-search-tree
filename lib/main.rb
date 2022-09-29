require_relative 'binary_search_tree'

test_array = (Array.new(15) { rand(1..100) })

p test_array.uniq.sort

binary_search_tree = Tree.new(test_array)

binary_search_tree.pretty_print