class AddTrailerToFilmables < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :omdb_trailer, :string
    add_column :movies, :trailer, :string

    add_column :series, :omdb_trailer, :string
    add_column :series, :trailer, :string
  end
end
