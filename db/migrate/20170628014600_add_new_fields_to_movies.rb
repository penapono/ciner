class AddNewFieldsToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :playing_soon, :boolean, default: false
    add_column :movies, :available_netflix, :boolean, default: false
    add_column :movies, :available_amazon, :boolean, default: false
  end
end
