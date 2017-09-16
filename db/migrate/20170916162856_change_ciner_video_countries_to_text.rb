class ChangeCinerVideoCountriesToText < ActiveRecord::Migration[5.1]
  def up
    change_column :ciner_videos, :countries, :text
    remove_column :ciner_videos, :ciner_video_genre
    remove_column :ciner_videos, :ciner_video_rated
    add_column :ciner_videos, :film_production_categories, :text
    add_column :ciner_videos, :ciner_video_ratings, :text
  end

  def down
    change_column :ciner_videos, :countries, :string
    add_column :ciner_videos, :ciner_video_genre, :text
    add_column :ciner_videos, :ciner_video_rated, :text
  end
end

