class Item < ApplicationRecord
  has_many :bookings
  belongs_to :product

  validates :product, presence: true

  def reserved?(from, till)
    bookings.where("(rental_start <= ? AND rental_end > ?) OR (rental_start BETWEEN ? AND ?)", from, from, from, till).exists?
  end
end
