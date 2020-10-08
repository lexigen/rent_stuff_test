class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :item_id, uniqueness: { scope: [:user_id, :rental_start, :rental_end] }
end
