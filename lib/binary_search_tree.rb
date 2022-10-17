# frozen_string_literal: true

# Binary Search Tree Class
class Tree
  attr_accessor :root, :tree_array

  def initialize(tree_array)
    @tree_array = tree_array.uniq.sort
    @root = build_tree(@tree_array)
  end

  def build_tree(tree_array, start_point = 0, end_point = tree_array.length - 1)
    return nil if start_point > end_point

    mid_point = (start_point + end_point) / 2
    root = Node.new(tree_array[mid_point])

    root.left_child = build_tree(tree_array, start_point, mid_point - 1)
    root.right_child = build_tree(tree_array, mid_point + 1, end_point)

    root
  end

  def insert(data, node = @root)
    comparison = node.data <=> data
    case comparison
    when 0
      nil
    when -1
      node.right_child.nil? ? node.right_child = create_node(data) : insert(data, node.right_child)
    when 1
      node.left_child.nil? ? node.left_child = create_node(data) : insert(data, node.left_child)
    end
  end

  def delete(data, node = @root)
    return node if node.nil?

    if node.data > data
      node.left_child = delete(data, node.left_child)
    elsif node.data < data
      node.right_child = delete(data, node.right_child)
    else
      return node.right_child if node.left_child.nil?
      return node.left_child if node.right_child.nil?

      leftmost_node = leftmost_leaf(node.right_child)
      node.data = leftmost_node.data
      node.right_child = delete(leftmost_node.data, node.right_child)
    end
    node
  end

  def find(data, node = @root)
    comparison = node.data <=> data
    case comparison
    when 0
      node
    when -1
      node.right_child.nil? ? nil : find(data, node.right_child)
    when 1
      node.left_child.nil? ? nil : find(data, node.left_child)
    end
  end

  def level_order(node = @root, queue = [], results = [])
    block_given? ? yield(node) : results << node.data
    queue << node.left_child unless node.left_child.nil?
    queue << node.right_child unless node.right_child.nil?
    return results if queue.empty?

    level_order(queue.shift, queue, results)
  end

  def preorder(node = @root, results = [])
    return if node.nil?

    block_given? ? yield(node) : results << node.data
    preorder(node.left_child, results)
    preorder(node.right_child, results)

    results
  end

  def inorder(node = @root, results = [])
    return if node.nil?

    inorder(node.left_child, results)
    block_given? ? yield(node) : results << node.data
    inorder(node.right_child, results)

    results
  end

  def postorder(node = @root, results = [])
    return if node.nil?

    postorder(node.left_child, results)
    postorder(node.right_child, results)
    block_given? ? yield(node) : results << node.data

    results
  end

  def height(node = @root, height_count = -1)
    return height_count if node.nil?

    height_count += 1
    [height(node.left_child, height_count), height(node.right_child, height_count)].max
  end

  def depth(node, current_node = @root, depth_count = -1)
    return nil if node.nil?

    depth_count += 1
    comparison = current_node.data <=> node.data

    case comparison
    when -1
      depth(node, current_node.right_child, depth_count)
    when 0
      depth_count
    when 1
      depth(node, current_node.left_child, depth_count)
    end
  end

  def balanced?
    (height(@root.left_child) - height(@root.right_child)).abs <= 1
  end

  def rebalance!
    @root = build_tree(inorder)
  end

  # Helper methods

  def create_node(data)
    Node.new(data)
  end

  def leftmost_leaf(node)
    node = node.left_child until node.left_child.nil?

    node
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
