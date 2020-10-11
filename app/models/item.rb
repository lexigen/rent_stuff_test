class Item < ApplicationRecord
  has_many :bookings
  belongs_to :product

  validates :product, presence: true
end
