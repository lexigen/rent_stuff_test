class Item < ApplicationRecord
  has_many :bookings
  belongs_to :product

  validates :product, presence: true

  def reserved?(from, till)
    bookings.each do |booking|
      if (booking.rental_start <= from && booking.rental_end > from) ||
         (booking.rental_start >= from && booking.rental_start <= till)
        return true
      end
    end

    false
  end
end
