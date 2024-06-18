require_relative 'linked_list'

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

hm = HashMap.new
hm.set('Fred', 1)
hm.set('George', 2)
hm.set('Harry', 3)
hm.set('Ginny', 4)
hm.set('Ron', 5)
hm.set('Sirius', 6)
hm.set('Luna', 7)
hm.set('Remus', 8)
hm.set('Severus', 9)
hm.set('Albus', 10)
hm.set('Cho', 11)
hm.set('James', 15)
hm.set('Dobby', 18)
hm.set('Arthur', 22)
hm.set('Charlie', 25)
hm.set('Dolores', 27)
hm.set('Samuel', 69)
hm.set('Draco', 16)
hm.set('Lily', 14)
hm.set('Rubeus', 17)
hm.set('Hedwig', 14)
hm.set('Myrtle', 15)
hm.set('Neville', 19)
hm.set('Alastor', 20)
hm.set('Molly', 21)
hm.set('Argus', 26)
hm.set('Cedric', 12)
hm.set('Minerva', 13)
p hm.remove('Kat')
