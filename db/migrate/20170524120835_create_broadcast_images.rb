class CreateBroadcastImages < ActiveRecord::Migration[5.0]
  def change
    create_table :broadcast_images do |t|
      t.references :broadcast, index: false
      t.string :media

      t.timestamps null: false
    end
  end
end
