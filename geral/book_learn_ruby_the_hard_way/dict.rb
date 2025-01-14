# frozen_string_literal: true

module Dict
  module_function

  def new(num_buckets = 256)
    result = []

    num_buckets.times do
      result.push([])
    end

    result
  end

  def list(dict)
    dict.each do |bucket|
      bucket&.each { |k, v| puts k, v }
    end
  end

  def set(dict, key, value)
    bucket = get_bucket(dict, key)
    i, = get_slot(dict, key)

    if i >= 0
      bucket[i] = [key, value]
    else
      bucket.push([key, value])
    end
  end

  def delete(dict, key)
    bucket = get_bucket(dict, key)

    (0...bucket.length).each do |i|
      k, = bucket[i]

      if key == k
        bucket.delete_at(i)
        break
      end
    end
  end

  def get(dict, key, default = nil)
    _, _, v = get_slot(dict, key, default = default)

    v
  end

  def get_slot(dict, key, default = nil)
    bucket = get_bucket(dict, key)

    bucket.each_with_index do |(k, v), i|
      return i, k, v if key == k
    end

    [-1, key, default]
  end

  def get_bucket(dict, key)
    bucket_id = hash_key(dict, key)
    dict[bucket_id]
  end

  def hash_key(dict, key)
    key.hash % dict.length
  end
end
