class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
