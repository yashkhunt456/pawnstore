class AddDeletedAtToProduct < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :deleted_at, :datetime
    add_index :products, :deleted_at
  end
end
