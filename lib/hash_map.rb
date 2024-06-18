class HashMap
  attr_reader :length

  def initialize(buckets_size = 16)
    @buckets = Array.new(buckets_size)
    @length = 0
  end

  def capacity
    @buckets.size
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code % @buckets.length
  end

  def set(key, value)
    @length += 1
    index = hash(key)
    @buckets[index] = [key, value]
  end

  def get(key)
    if @buckets[hash(key)].nil?
      nil
    else
      @buckets[hash(key)][1]
    end
  end

  def has?(key)
    !@buckets[hash(key)].nil?
  end

  def remove(key)
    if !has?(key)
      nil
    else
      deleted = @buckets[hash(key)]
      @buckets[hash(key)] = nil
      @length -= 1
      deleted[1]
    end
  end

  def clear
    @buckets = Array.new(capacity)
  end

  def keys
    key_arr = []
    @buckets.each do |item|
      key_arr << item[0] unless item.nil?
    end
    key_arr
  end

  def values
    value_arr = []
    @buckets.each do |item|
      value_arr << item[1] unless item.nil?
    end
    value_arr
  end

  def entries
    entry_arr = []
    @buckets.each do |item|
      entry_arr << item unless item.nil?
    end
    entry_arr
  end
end

hm = HashMap.new
hm.set('Fred', 8)
hm.set('George', 8)
hm.set('Harry', 4)
hm.set('Ginny', 1)
hm.set('Ron', 2)
hm.set('Sirius', 4)
p hm.length
