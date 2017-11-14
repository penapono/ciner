class CreateTrophies < ActiveRecord::Migration[5.1]
  def change
    create_table :trophies do |t|
      t.string :name
      t.text :description
      t.integer :level

      t.timestamps null: false
    end
  end
end
