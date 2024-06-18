# frozen_string_literal: true

# node is part of a linked list
class Node
  attr_accessor :data, :next_node, :key

  def initialize(key = nil, value = nil, next_node = nil)
    @key = key
    @data = value
    @next_node = next_node
  end
end
