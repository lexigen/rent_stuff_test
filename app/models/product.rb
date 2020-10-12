class Product < ApplicationRecord
  has_many :items
  validates :name, uniqueness: true
  validates :quantity, numericality: { only_integer: true }

  def available(params)
    from = DateTime.parse(params[:from])
    till = DateTime.parse(params[:till])
    quantity - reserved_items_count(from, till)
  end

  def reserved_items_count(from, till)
    sql = <<-SQL
    SELECT COUNT(DISTINCT items.id) FROM items
    INNER JOIN products on products.id = items.product_id
    INNER JOIN bookings ON items.id = bookings.item_id
    WHERE products.id = '#{id}' AND bookings.rental_start <= '#{till}' AND '#{from}' <= bookings.rental_end
    SQL

    ActiveRecord::Base.connection.select_value(sql).to_i
  end
end
