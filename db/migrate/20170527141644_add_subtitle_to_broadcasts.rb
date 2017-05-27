class AddSubtitleToBroadcasts < ActiveRecord::Migration[5.0]
  def change
    add_column :broadcasts, :subtitle, :string
  end
end
