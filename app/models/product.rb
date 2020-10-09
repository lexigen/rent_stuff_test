class Product < ApplicationRecord
  has_many :items
  validates :name, uniqueness: true
  validates :quantity, numericality: { only_integer: true }
end
