class Product < ApplicationRecord
  has_many :items
  validates :name, uniqueness: true
  validates :quantity, numericality: { only_integer: true }

  def self.available(from, till)
    from = DateTime.parse from
    till = DateTime.parse till
    products = Product.includes(items: :bookings)
    products.each.with_object([]) do |product, available_products|
      reserved_items = product.items.each.with_object([]) do |item, ary|
        ary << item.id if item.reserved?(from, till)
      end
      available_products << {
        product_id: product.id,
        available: (product.quantity - reserved_items.uniq.size),
        total: product.quantity
      }
    end
  end
end
