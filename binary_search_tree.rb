require_relative 'node'

class BinarySearchTree
  def initialize
    @head = nil
  end


  ##REFACTOR THIS##
  def insert(key, value, potential_parent_node = @head, depth = 0)
    if @head == nil
      @head = Node.new(key, value)
      depth
    elsif key < potential_parent_node.key
      if potential_parent_node.left_child
        depth += 1
        self.insert(key, value, potential_parent_node.left_child, depth)
      else
        potential_parent_node.left_child = Node.new(key, value)
        depth += 1
        depth
      end
    elsif key > potential_parent_node.key
      if potential_parent_node.right_child
        depth += 1
        self.insert(key, value, potential_parent_node.right_child, depth)
      else
        potential_parent_node.right_child = Node.new(key, value)
        depth += 1
        depth
      end
    end
  end

  # def include?(search_value, node = @head)
  #   if node.key == search_value
  #     true
  #   elsif node.key > search_value
  #
  #   elsif node.key < search_value
  #
  #
  # end

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
