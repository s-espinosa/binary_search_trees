require_relative 'node'
require 'pry'

class BinarySearchTree
  attr_reader :head

  def initialize
    @head = nil
  end

  def insert(key, value)
    new_node = Node.new(key, value)
    if @head.nil?
      @head = new_node
      return 0
    else
      @head.push(new_node)
    end
    new_node.depth
  end

  def include?(search_key, node = @head)
    if node == nil
      false
    elsif node.key == search_key
      true
    elsif node.key > search_key
      include?(search_key, node.left_child)
    else node.key < search_key
      include?(search_key, node.right_child)
    end
  end

  def depth_of(key)
    check_node = @head

    until key == check_node.key
      if key < check_node.key
        check_node = check_node.left_child
      else
        check_node = check_node.right_child
      end
    end
    check_node.depth
  end

  def max
    current_node = @head
    until current_node.right_child == nil
      current_node = current_node.right_child
    end
    {current_node.value => current_node.key}
  end

  def min
    current_node = @head
    until current_node.left_child == nil
      current_node = current_node.left_child
    end
    {current_node.value => current_node.key}
  end

  def sort
    sort_array = []
    sort_recursively(@head, sort_array)
    sort_array
  end

  def sort_recursively(node, sort_array)
    sort_recursively(node.left_child, sort_array) if node.left_child
    sort_array.push({node.value => node.key})
    sort_recursively(node.right_child, sort_array) if node.right_child
  end

  def load(from_file)
    files_added = 0
    File.readlines(from_file).count do |line|
      line = line.chomp
      line_array = line.split(", ")
      if include?(line_array[0].to_i)
        #skip
      else
        insert(line_array[0].to_i, line_array[1])
        files_added += 1
      end
    end
    files_added
  end

  def health(depth)
    all_nodes = count_children_and_parent(@head, 0)
    nodes_array = collect_nodes_at_depth(depth)
    nodes_array.map do |node|
      node_children = count_children_and_parent(node)
      percent_of_tree = ((node_children.to_f / all_nodes.to_f)*100).to_i
      [node.key, node_children, percent_of_tree]
    end
  end

  def count_children_and_parent(node, count = 0)
    count = count_children_and_parent(node.left_child, count) if node.left_child
    count += 1
    count = count_children_and_parent(node.right_child, count) if node.right_child
    count
  end

  def collect_nodes_at_depth(depth, collection = [], node = @head)
    collection = collect_nodes_at_depth(depth, collection, node.left_child) if node.left_child
    collection << node if node.depth == depth
    collection = collect_nodes_at_depth(depth, collection, node.right_child) if node.right_child
    collection
  end

  def leaves(count = 0, node = @head)
    count = leaves(count, node.left_child) if node.left_child
    count += 1 if node.left_child.nil? && node.right_child.nil?
    count = leaves(count, node.right_child) if node.right_child
    count
  end

end
