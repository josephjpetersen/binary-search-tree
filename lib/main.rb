require_relative 'binary_search_tree'

test_array = [4, 8, 15, 16, 23, 42, 69, 93, 7, 64, 71, 99, 13, 66, 55]

p test_array.uniq.sort

binary_search_tree = Tree.new(test_array)

binary_search_tree.pretty_print

binary_search_tree.insert(3)

binary_search_tree.pretty_print