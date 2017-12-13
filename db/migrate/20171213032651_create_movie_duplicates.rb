class CreateMovieDuplicates < ActiveRecord::Migration[5.1]
  def change
    create_table :movie_duplicates do |t|
      t.text :title
      t.text :available_years
      t.integer :count

      t.timestamps null: false
    end
  end
end
