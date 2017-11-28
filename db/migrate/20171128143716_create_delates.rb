class CreateDelates < ActiveRecord::Migration[5.1]
  def change
    create_table :delates do |t|
      t.string :location
      t.string :status

      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
