class AddDeletedAtToBroadcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :broadcasts, :deleted_at, :datetime
    add_index :broadcasts, :deleted_at
  end
end
