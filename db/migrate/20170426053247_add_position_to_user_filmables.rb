class AddPositionToUserFilmables < ActiveRecord::Migration[5.0]
  def change
    add_column :user_filmables, :position, :integer
  end
end
