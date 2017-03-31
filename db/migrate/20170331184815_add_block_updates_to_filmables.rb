class AddBlockUpdatesToFilmables < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :lock_updates, :boolean, default: false
    add_column :series, :lock_updates, :boolean, default: false
    add_column :professionals, :lock_updates, :boolean, default: false
  end
end
