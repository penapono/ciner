class AddIdFieldsToFilmables < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :omdb_id, :string

    add_column :series, :omdb_id, :string
  end
end
