class AddPositionToTrophies < ActiveRecord::Migration[5.1]
  def change
    add_column :trophies, :position, :integer, default: 0
  end
end
