FactoryBot.define do
  factory :product do
    sequence :name do |n|
      "product_#{n}"
    end
    quantity { 3 }
  end
end
