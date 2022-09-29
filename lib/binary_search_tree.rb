# frozen_string_literal: true

# Binary Search Tree Class
class Tree
  attr_accessor :root, :tree_array

  def initialize(tree_array)
    @tree_array = tree_array.uniq.sort
    @root = build_tree(@tree_array)
  end

  def build_tree(tree_array = @tree_array, start_point = 0, end_point = @tree_array.length - 1)
    return nil if start_point > end_point

    mid_point = (start_point + end_point) / 2
    root = Node.new(tree_array[mid_point])

    root.left_child = build_tree(tree_array, start_point, mid_point - 1)
    root.right_child = build_tree(tree_array, mid_point + 1, end_point)

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  # Node subclass to populate Tree
  class Node
    include Comparable
    attr_accessor :data, :left_child, :right_child

    def initialize(data = nil, left_child = nil, right_child = nil)
      @data = data
      @left_child = left_child
      @right_child = right_child
    end

    def <=>(other)
      @data <=> other.data
    end
  end
end
