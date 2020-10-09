class Product < ApplicationRecord
  has_many :items
  validates :name, uniqueness: true
  validates :quantity, numericality: { only_integer: true }

  def self.available(from, till)
    from = DateTime.parse from
    till = DateTime.parse till
    available_products = []
    products = Product.includes(items: :bookings)
    products.each do |product|
      reserved_items = []
      product.items.each do |item|
        reserved_items << item.id if item.reserved?(from, till)
      end
      available_products << { product_id: product.id, total: product.quantity, available: (product.quantity - reserved_items.uniq.size) }
    end
    available_products
  end
end
