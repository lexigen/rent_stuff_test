class Product < ApplicationRecord
  has_many :items
  validate :name, uniqueness: true
  validate :quantity, numericality: { only_integer: true }
end
