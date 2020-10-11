class Product < ApplicationRecord
  has_many :items
  validates :name, uniqueness: true
  validates :quantity, numericality: { only_integer: true }

  def available(params)
    reserved_items = items.each.with_object([]) do |item, ary|
      ary << item.id if item.reserved?(DateTime.parse(params[:from]), DateTime.parse(params[:till]))
    end
    quantity - reserved_items.uniq.size
  end
end
