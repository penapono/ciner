class AddFieldsToFilmables < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :omdb_rated, :string
    add_column :series, :omdb_rated, :string
  end
end
