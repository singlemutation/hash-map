# frozen_string_literal: true

require_relative 'linked_list'

# handle making a hashmap out of keys and values
class HashMap
  attr_reader :length, :buckets

  def initialize(buckets_size = 16)
    @buckets = Array.new(buckets_size)
    @length = 0
  end

  LOAD_FACTOR = 0.8

  def grow
    capacity.times { @buckets << nil }
  end

  def capacity
    @buckets.size
  end

  def filled_buckets
    capacity - @buckets.count(nil)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code % @buckets.size
  end

  def set(key, value)
    @length += 1
    index = hash(key)
    @buckets[index] ||= LinkedList.new
    @buckets[index].append(key, value)
    grow if filled_buckets > (capacity * LOAD_FACTOR)
  end

  def get(key)
    if @buckets[hash(key)].nil?
      nil
    else
      @buckets[hash(key)].find(key)
    end
  end

  def has?(key)
    return false if @buckets[hash(key)].nil?

    @buckets[hash(key)].contains?(key)
  end

  def remove(key)
    if !has?(key)
      nil
    else
      @buckets[hash(key)].remove(key)
      @buckets[hash(key)].removed
      @length -= 1
    end
  end

  def clear
    @buckets = Array.new(capacity)
  end

  def keys
    key_arr = []
    @buckets.each do |item|
      key_arr << item.keys unless item.nil?
    end
    key_arr.flatten
  end

  def values
    value_arr = []
    @buckets.each do |item|
      value_arr << item.values unless item.nil?
    end
    value_arr.flatten
  end

  def entries
    entry_arr = []
    @buckets.each do |item|
      entry_arr << item.keys_with_values unless item.nil?
    end
    entry_arr.flatten(1)
  end
end
