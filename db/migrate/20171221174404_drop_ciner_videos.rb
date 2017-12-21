class DropCinerVideos < ActiveRecord::Migration[5.1]
  def change
    drop_table :ciner_videos
  end
end
