class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.date :event_date
      t.time :start_time
      t.time :end_time
      t.text :description

      t.timestamps null: false
    end
  end
end
