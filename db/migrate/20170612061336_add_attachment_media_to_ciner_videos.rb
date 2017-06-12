class AddAttachmentMediaToCinerVideos < ActiveRecord::Migration
  def self.up
    change_table :ciner_videos do |t|
      t.attachment :media
    end
  end

  def self.down
    remove_attachment :ciner_videos, :media
  end
end
