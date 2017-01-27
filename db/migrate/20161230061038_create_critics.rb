class CreateCritics < ActiveRecord::Migration
  def change
    create_table :critics do |t|
      t.references :user, index: true
      t.references :filmable, polymorphic: true, index: true

      t.text :content
      t.integer :rating

      t.integer :filmable_release_year

      t.float :rating

      t.integer :status, default: 1
      t.integer :origin, default: 2

      t.timestamps null: false
    end
  end
end
