class AddContentTypesToBroadcasts < ActiveRecord::Migration[5.0]
  def change
    add_column :broadcasts, :movie_content, :boolean, default: false
    add_column :broadcasts, :serie_content, :boolean, default: false
    add_column :broadcasts, :celebrity_content, :boolean, default: false
  end
end
