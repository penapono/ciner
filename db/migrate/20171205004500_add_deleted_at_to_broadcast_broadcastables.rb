class AddDeletedAtToBroadcastBroadcastables < ActiveRecord::Migration[5.1]
  def change
    add_column :broadcast_broadcastables, :deleted_at, :datetime
    add_index :broadcast_broadcastables, :deleted_at
  end
end
