class Item < ApplicationRecord
  has_many :bookings

  def reserved?(from, till)
    from = DateTime.parse(from])
    till = DateTime.parse(till)
    bookings.where("(rental_start <= ? AND rental_end > ?) OR (rental_start BETWEEN ? AND ?)", from, from, from, till).exists?
  end
end
