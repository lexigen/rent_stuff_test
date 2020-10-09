# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

product = Product.find_or_create_by(name: 'Nikon D700', quantity: 10)
5.times do |sku|
  Item.find_or_create_by(product: product, sku: "nsku_#{sku}")
end
