class AddOriginToFilmables < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :countries, :string
    add_column :series, :countries, :string
  end
end
