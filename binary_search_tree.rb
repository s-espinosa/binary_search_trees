require_relative 'node'

class BinarySearchTree
  attr_reader :head

  def initialize
    @head = nil
  end

  def insert(key, value, potential_parent_node = @head)
    if @head == nil
      @head = Node.new(key, value)
      0
    else
      insertion_point, depth = find_insertion_point(key, value, potential_parent_node)
      add_leaf(key, value, insertion_point)
      depth
    end
  end

  def find_insertion_point(key, value, potential_parent, depth = 0)
    if potential_parent.key > key
      depth += 1
      check_child(key, value, potential_parent, potential_parent.left_child, depth)
    else
      depth += 1
      check_child(key, value, potential_parent, potential_parent.right_child, depth)
    end
  end

  def check_child(key, value, parent, child, depth)
    if child == nil
      [parent, depth]
    else
      find_insertion_point(key, value, child, depth)
    end
  end

  def add_leaf(key, value, parent)
    if parent == nil
      Node.new(key, value)
    elsif parent.key > key
      parent.left_child = Node.new(key, value)
    else
      parent.right_child = Node.new(key, value)
    end
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
    depth = 0
    check_node = @head

    until key == check_node.key
      if key < check_node.key
        depth += 1
        check_node = check_node.left_child
      else
        depth += 1
        check_node = check_node.right_child
      end
    end
    depth
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
    sorted_list = add_next_leftmost_node(Array.new, @head)
  end

  def add_next_leftmost_node(partially_sorted_array, current_node)
    if partially_sorted_array == []
      min_node_values = min
      partially_sorted_array = [min_node_values]
      add_next_leftmost_node(partially_sorted_array, @head)
    elsif current_node.left_child
      if {current_node.left_child.value => current_node.left_child.key} == partially_sorted_array.last
        if current_node.left_child.right_child
          add_next_leftmost_node(partially_sorted_array, current_node.left_child.right_child)
        else
          hash_to_add = {current_node.value => current_node.key}
          partially_sorted_array.push(hash_to_add)
          add_next_leftmost_node(partially_sorted_array, current_node.right_child)
        end
      else
        add_next_leftmost_node(partially_sorted_array, current_node.left_child)
      end
    else
      if current_node.right_child
        add_next_leftmost_node(partially_sorted_array, current_node.right_child)
      else
        hash_to_add = {current_node.value => current_node.key}
        partially_sorted_array.push(hash_to_add)
      end
    end

    partially_sorted_array
  end


  # def load
  #
  # end
  #
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
