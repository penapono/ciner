class AddDeletedAtToCritics < ActiveRecord::Migration[5.1]
  def change
    add_column :critics, :deleted_at, :datetime
    add_index :critics, :deleted_at
  end
end
