class AddProductIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :product, foreign_key: true, index: true
  end
end
