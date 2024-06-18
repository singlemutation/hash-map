require_relative 'node'

class LinkedList
  attr_reader :head, :tail, :removed

  def initialize
    @head = nil
    @tail = nil
  end

  def append(key, value)
    new_node = Node.new(key, value)
    if @head.nil?
      @head = new_node
    else
      @tail.next_node = new_node
    end
    @tail = new_node
  end

  def prepend(key, value)
    new_node = Node.new(key, value, @head)
    @head = new_node
  end

  def size
    count = 0
    element = @head
    until element.nil?
      count += 1
      element = element.next_node
    end
    count
  end

  def at(index)
    element = @head
    index.times do
      element = element.next_node
    end
    element
  end

  def pop
    @tail = at(size - 2)
    at(size - 2).next_node = nil
  end

  def contains?(value)
    element = @head
    until element.nil?
      return true if element.key == value

      element = element.next_node
    end
    false
  end

  def keys
    element = @head
    keys = []
    until element.nil?
      keys << element.key
      element = element.next_node
    end
    keys
  end

  def values
    element = @head
    values = []
    until element.nil?
      values << element.data
      element = element.next_node
    end
    values
  end

  def keys_with_values
    element = @head
    keys_with_values = []
    until element.nil?
      keys_with_values << [element.key, element.data]
      element = element.next_node
    end
    keys_with_values
  end

  def find(value)
    element = @head
    until element.nil?
      return element.data if element.key == value

      element = element.next_node
    end
  end

  def remove(value)
    element = @head
    element = element.next_node until element.next_node.key == value
    prev = element
    element = element.next_node
    @removed = element.data
    prev.next_node = element.next_node
  end

  def to_s
    element = @head
    until element.nil?
      print "(#{element.key}) -> "
      element = element.next_node
    end
    puts 'nil'
  end
end
