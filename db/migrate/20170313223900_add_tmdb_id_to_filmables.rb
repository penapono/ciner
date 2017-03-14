class AddTmdbIdToFilmables < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :tmdb_id, :integer
    add_column :series, :tmdb_id, :integer
    add_column :professionals, :tmdb_id, :integer
  end
end
