# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find_or_create_by(name: 'Jan', email: 'jan@mail.com')

product_1 = Product.find_or_create_by(name: 'Nikon D700', quantity: 10)
product_2 = Product.find_or_create_by(name: 'Canon EOS R', quantity: 10)

10.times do |sku|
  Item.find_or_create_by(product: product_1, sku: "nsku_#{sku}")
end

10.times do |sku|
  Item.find_or_create_by(product: product_2, sku: "csku_#{sku}")
end

Booking.find_or_create_by(
  user: user, item: Item.find_by(sku: 'nsku_7'),
  rental_start: DateTime.parse("2012-9-14 09:00:00"),
  rental_end: DateTime.parse("2012-9-19 19:00:00")
)

Booking.find_or_create_by(
  user: user, item: Item.find_by(sku: 'nsku_5'),
  rental_start: DateTime.parse("2012-9-20 12:00:00"),
  rental_end: DateTime.parse("2012-9-22 12:00:00")
)

Booking.find_or_create_by(
  user: user, item: Item.find_by(sku: 'nsku_5'),
  rental_start: DateTime.parse("2012-9-27 09:00:00"),
  rental_end: DateTime.parse("2012-10-03 09:00:00")
)

Booking.find_or_create_by(
  user: user, item: Item.find_by(sku: 'nsku_8'),
  rental_start: DateTime.parse("2012-10-02 09:00:00"),
  rental_end: DateTime.parse("2012-10-05 09:00:00")
)

Booking.find_or_create_by(
  user: user, item: Item.find_by(sku: 'csku_5'),
  rental_start: DateTime.parse("2012-10-04 09:00:00"),
  rental_end: DateTime.parse("2012-10-06 09:00:00")
)

Booking.find_or_create_by(
  user: user, item: Item.find_by(sku: 'csku_4'),
  rental_start: DateTime.parse("2012-10-05 09:00:00"),
  rental_end: DateTime.parse("2012-10-09 09:00:00")
)

Booking.find_or_create_by(
  user: user, item: Item.find_by(sku: 'csku_5'),
  rental_start: DateTime.parse("2012-10-08 09:00:00"),
  rental_end: DateTime.parse("2012-10-09 09:00:00")
)

Booking.find_or_create_by(
  user: user, item: Item.find_by(sku: 'csku_1'),
  rental_start: DateTime.parse("2012-10-07 17:00:00"),
  rental_end: DateTime.parse("2012-10-10 09:00:00")
)