class CreateUserFilmableRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :user_filmable_ratings do |t|
      t.references :user, index: true
      t.references :filmable, polymorphic: true, index: true
      t.integer :rating
      t.datetime :deleted_at, index: true

      t.timestamps null: false
    end
  end
end
