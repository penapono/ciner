class RemoveTrailerFromCinerVideos < ActiveRecord::Migration[5.0]
  def change
    remove_column :ciner_videos, :trailer
  end
end
