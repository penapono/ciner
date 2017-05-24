class AddSourceToBroadcasts < ActiveRecord::Migration[5.0]
  def change
    add_column :broadcasts, :source, :string
  end
end
