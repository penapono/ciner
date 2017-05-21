class AddFieldsToBroadcasts < ActiveRecord::Migration[5.0]
  def change
    add_column :broadcasts, :cover, :string
    add_column :broadcasts, :more, :string
    add_column :broadcasts, :video, :string
    add_column :broadcasts, :broadcast_date, :date
  end
end
