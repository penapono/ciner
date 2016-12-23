class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.string :name
      t.references :country
      t.references :state
      t.references :city

      t.timestamps null: false
    end
  end
end
