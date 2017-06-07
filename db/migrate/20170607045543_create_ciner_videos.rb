class CreateCinerVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :ciner_videos do |t|
      t.string :original_title
      t.string :title
      t.integer :year
      t.string :length
      t.text :synopsis
      t.date :release
      t.integer :city_id
      t.integer :state_id
      t.integer :age_range_id
      t.string :cover
      t.text :ciner_video_directors
      t.text :ciner_video_writers
      t.text :ciner_video_actors
      t.text :ciner_video_genre
      t.text :ciner_video_rated
      t.string :trailer
      t.string :media
      t.boolean :playing
      t.string :countries

      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
