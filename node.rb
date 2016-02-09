class Node
  attr_reader :key, :value
  attr_accessor :left_child, :right_child

  def initialize(key, value, parent = nil)
    @key = key
    @value = value
    @left_child = nil
    @right_child = nil
  end
end
