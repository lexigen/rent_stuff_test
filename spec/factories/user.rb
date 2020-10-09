FactoryBot.define do
  factory :user do
    name { 'Jan' }
    sequence :email do |n|
      "jan_#{n}@mail.com"
    end
  end
end
