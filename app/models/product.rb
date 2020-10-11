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
    items.each.with_object([]) do |item, ary|
      item.bookings.each do |booking|
        ary << item.id if (booking.rental_start <= till) && (from <= booking.rental_end)
      end
    end.uniq.size
  end
end
