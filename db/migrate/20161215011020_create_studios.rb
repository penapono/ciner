class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.string :name
      t.date :creation
      t.references :country

      t.timestamps null: false
    end
  end
end
