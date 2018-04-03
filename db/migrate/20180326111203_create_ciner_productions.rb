class CreateCinerProductions < ActiveRecord::Migration[5.1]
  def change
    create_table :ciner_productions do |t|
      t.string :original_title
      t.string :title
      t.integer :year
      t.string :length
      t.text :synopsis
      t.date :release
      t.date :brazilian_release
      t.integer :age_range_id
      t.string :cover
      t.text :omdb_genre
      t.text :omdb_rated
      t.text :trailer
      t.string :countries
      t.boolean :playing
      t.boolean :playing_soon
      t.boolean :available_netflix
      t.boolean :available_amazon
      t.integer :comments_count
      t.integer :production_type
      t.integer :status

      # Reacting
      t.integer :likes_count, default: 0
      t.integer :dislikes_count, default: 0

      t.references :user, index: true

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
