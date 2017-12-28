class AddIndexOnMovies < ActiveRecord::Migration[5.1]
  def change
    add_index :movies, :playing
  end
end
