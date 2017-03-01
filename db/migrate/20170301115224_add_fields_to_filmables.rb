class AddFieldsToFilmables < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :omdb_directors, :string
    add_column :movies, :omdb_writers, :string
    add_column :movies, :omdb_actors, :string
    add_column :movies, :omdb_genre, :string
    add_column :movies, :omdb_rated, :string

    add_column :series, :omdb_directors, :string
    add_column :series, :omdb_writers, :string
    add_column :series, :omdb_actors, :string
    add_column :series, :omdb_genre, :string
    add_column :series, :omdb_rated, :string
  end
end
