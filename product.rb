# frozen_string_literal: true

class Product
  def initialize(name, price)
    self.name = name
    self.price = price

  end

  def get_name
    name
  end

  def get_price
    price
  end

  private

  attr_writer :name, :price
  attr_accessor :name,:price
end
