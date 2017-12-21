class DropCinerVideoUsers < ActiveRecord::Migration[5.1]
  def change
    drop_table :ciner_video_users
  end
end
