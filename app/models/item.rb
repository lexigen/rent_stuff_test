class Item < ApplicationRecord
  has_many :bookings
  belongs_to :product

  validates :product, presence: true

  def reserved?(from, till)
    bookings.each do |booking|
      return true if (booking.rental_start <= till) && (from <= booking.rental_end)
    end

    false
  end
end
