FactoryBot.define do
  factory :booking do
    item { build(:item) }
    user { build(:user) }
    rental_start { DateTime.now - 2.weeks }
    rental_end { DateTime.now - 1.week }
  end
end
