class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :item_id, uniqueness: { scope: [:user_id, :rental_start, :rental_end] }
  validates :user, presence: true
  validates :rental_start, presence: true
  validates :rental_end, presence: true
end
