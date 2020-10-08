class RemoveTotalFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :total
  end
end
