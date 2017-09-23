class AddMediaProcessingToCinerVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :ciner_videos, :media_processing, :boolean, null: false, default: false
    add_column :ciner_videos, :trailer_processing, :boolean, null: false, default: false
    add_column :ciner_videos, :media, :string
    add_column :ciner_videos, :trailer, :string
  end
end
