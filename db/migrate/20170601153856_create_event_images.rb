class CreateEventImages < ActiveRecord::Migration[5.0]
  def change
    create_table :event_images do |t|
      t.references :event, index: false
      t.string :media

      t.timestamps null: false
    end
  end
end
