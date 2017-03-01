class AddFieldsToMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :omdb_directors, :string
    add_column :movies, :omdb_writers, :string
    add_column :movies, :omdb_actors, :string
    add_column :movies, :omdb_genre, :string
  end
end
