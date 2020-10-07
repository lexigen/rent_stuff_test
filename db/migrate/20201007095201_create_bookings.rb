class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.timestamp :rental_start
      t.timestamp :rental_end

      t.timestamps
    end
  end
end
