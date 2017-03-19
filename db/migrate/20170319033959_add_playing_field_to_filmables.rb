class AddPlayingFieldToFilmables < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :playing, :boolean, default: false
    add_column :series, :playing, :boolean, default: false
  end
end
