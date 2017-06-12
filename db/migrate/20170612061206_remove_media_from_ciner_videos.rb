class RemoveMediaFromCinerVideos < ActiveRecord::Migration[5.0]
  def change
    remove_column :ciner_videos, :media
  end
end
