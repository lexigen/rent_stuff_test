class Product < ApplicationRecord
  has_many :items
  validates :name, uniqueness: true
  validates :quantity, numericality: { only_integer: true }

  def self.available(from, till)
    reserved_items = []
    available_products = {}
    products = Product.includes(items: :bookings)
    products.each do |product|
      product.items.each do |item|
        reserved_items << item.id if item.reserved?(from, till)
      end
      available_products.merge!(product_id: product.id, total: product.quantity, available: (product.quantity - reserved_items.uniq.size))
    end
    available_products
  end
end
