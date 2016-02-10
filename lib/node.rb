class Node
  attr_reader :key, :value
  attr_accessor :left_child, :right_child, :depth

  def initialize(key, value)
    @key = key
    @value = value
    @left_child = nil
    @right_child = nil
    @depth = 0
  end

  def push(node)
    if node.key < key && @left_child.nil?
      node.depth = node.depth + 1
      @left_child = node
    elsif node.key > key && @right_child.nil?
      node.depth = node.depth + 1
      @right_child = node
    elsif node.key < key
      node.depth = node.depth + 1
      @left_child.push(node)
    elsif node.key > key
      node.depth = node.depth + 1
      @right_child.push(node)
    else
      "Entry already exists."
    end
  end
end
