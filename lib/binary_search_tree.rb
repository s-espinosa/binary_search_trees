require_relative 'node'

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
    File.readlines(from_file).each do |line|
      line = line.chomp
      line_array = line.split(", ")
      insert(line_array[0].to_i, line_array[1])
      files_added += 1
    end
    files_added
  end

  # def health(level)
  #   # potential_nodes_at_level = 2 ** level
  #   # unfiltered_node_colection = []
  #
  #   # until unfiltered_node_collection.length == potential_nodes_at_level
  #   #
  #   #
  #   # end
  #
  #   ###FIND ALL THE NODES AT A CERTAIN LEVEL###
  #   # Start at the head
  #   # If possible, go left a number of times equal to the level
  #   #
  #   current_node = @head
  #   1.upto(level) do |node|
  #
  #   end
  #
  #   key = 98
  #   children_plus_one = 7
  #   children_plus_one_over_all_children = 100
  #   return_array = []
  #
  #   []
  # end
  #
  # def find_all_nodes_at_level(level)
  #   current_node = @head_node
  #   array_of_nodes = []
  #
  #   array_of_nodes.push(current_node.left_child)
  #   array_of_nodes.push(current_node.right_child)
  #
  #
  # end
  #
end
