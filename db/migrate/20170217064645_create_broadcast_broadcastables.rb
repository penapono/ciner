class CreateBroadcastBroadcastables < ActiveRecord::Migration[5.0]
  def change
    create_table :broadcast_broadcastables do |t|
      t.references :broadcastable, polymorphic: true, index: false
      t.references :broadcast, index: false

      t.timestamps null: false
    end
  end
end
