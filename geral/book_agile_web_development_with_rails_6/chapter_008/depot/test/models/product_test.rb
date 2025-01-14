require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'when title is nil or empty expect to has an error' do
    product = Product.new(title: '')
    product.valid?
    assert product.errors[:title].any?
  end

  test 'when description is nil or empty expect to has an error' do
    product = Product.new(description: '')
    product.valid?
    assert product.errors[:description].any?
  end

  test 'when image_url is nil or empty expect to has an error' do
    product = Product.new(image_url: '')
    product.valid?
    assert product.errors[:image_url].any?
  end

  test 'when price is less than 0.1 expect to has an error' do
    product = Product.new(price: 0)
    product.valid?
    assert product.errors[:price].any?
  end

  test 'when title is not unique expect to has an error' do
    ruby = products(:ruby)
    product = Product.new(title: ruby.title)
    product.valid?
    assert product.errors[:title].any?
  end

  test 'when image_url does not match the pattern expect to has an error' do
    product = Product.new(image_url: 'test')
    product.valid?
    assert product.errors[:image_url].any?
  end

  test 'when image_url matches the pattern expect to not has error' do
    product = Product.new(image_url: 'test.jpg')
    product.valid?
    assert product.errors[:image_url].empty?
  end
end
