class CreateCritics < ActiveRecord::Migration
  def change
    create_table :critics do |t|
      t.references :user, index: true
      t.references :city
      t.references :state
      t.references :country

      t.string :name
      t.text :content
      t.integer :rating

      t.timestamps null: false
    end
  end
end
