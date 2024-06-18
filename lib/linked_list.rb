require_relative 'node'

class LinkedList
  attr_reader :head, :tail

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
      return true if element.data == value

      element = element.next_node
    end
    false
  end

  def find(value)
    element = @head
    index = 0
    until element.nil?
      return index if element.data == value

      element = element.next_node
      index += 1
    end
  end

  def to_s
    element = @head
    until element.nil?
      print "(#{element.data}) -> "
      element = element.next_node
    end
    puts 'nil'
  end
end
