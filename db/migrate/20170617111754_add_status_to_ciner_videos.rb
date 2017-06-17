class AddStatusToCinerVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :ciner_videos, :status, :integer, default: 0
  end
end
