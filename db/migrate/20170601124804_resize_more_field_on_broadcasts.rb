class ResizeMoreFieldOnBroadcasts < ActiveRecord::Migration[5.0]
  def change
    change_column :broadcasts, :more, :text
  end
end
