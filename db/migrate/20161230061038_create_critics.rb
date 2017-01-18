class CreateCritics < ActiveRecord::Migration
  def change
    create_table :critics do |t|
      t.references :user, index: true
      t.references :filmable, polymorphic: true, index: true

      t.string :name
      t.text :content
      t.integer :rating

      t.timestamps null: false
    end
  end
end
