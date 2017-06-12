class AddAttachmentTrailerToCinerVideos < ActiveRecord::Migration
  def self.up
    change_table :ciner_videos do |t|
      t.attachment :trailer
    end
  end

  def self.down
    remove_attachment :ciner_videos, :trailer
  end
end
