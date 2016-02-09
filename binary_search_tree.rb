require_relative 'node'

class BinarySearchTree
  def initialize
    @head = nil
  end


  ##REFACTOR THIS##
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
      if potential_parent.left_child == nil
        depth += 1
        [potential_parent, depth]
      else
        depth += 1
        find_insertion_point(key, value, potential_parent.left_child, depth)
      end
    else
      if potential_parent.right_child == nil
        depth += 1
        [potential_parent, depth]
      else
        depth += 1
        find_insertion_point(key, value, potential_parent.right_child, depth)
      end
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

  # def depth_of?
  #
  # end
  #
  # def max
  #
  # end
  #
  # def min
  #
  # end
  #
  # def sort
  #
  # end
  #
  # def load
  #
  # end
  #
  # def health
  #
  # end
end
