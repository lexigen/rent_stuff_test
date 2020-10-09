FactoryBot.define do
  factory :item do
    sequence :sku do |n|
      "sku_#{n}"
    end
    product { build(:product) }
  end
end
