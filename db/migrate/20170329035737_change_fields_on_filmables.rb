class ChangeFieldsOnFilmables < ActiveRecord::Migration[5.0]
  def change
    change_column :movies, :omdb_directors, :text
    change_column :movies, :omdb_writers, :text
    change_column :movies, :omdb_actors, :text
    change_column :movies, :omdb_genre, :text
    change_column :movies, :omdb_rated, :text
    change_column :movies, :omdb_id, :text
    change_column :movies, :omdb_trailer, :text
    change_column :movies, :trailer, :text

    change_column :series, :omdb_directors, :text
    change_column :series, :omdb_writers, :text
    change_column :series, :omdb_actors, :text
    change_column :series, :omdb_genre, :text
    change_column :series, :omdb_rated, :text
    change_column :series, :omdb_id, :text
    change_column :series, :omdb_trailer, :text
    change_column :series, :trailer, :text
  end
end
