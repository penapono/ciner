class AddImdbIdToSeries < ActiveRecord::Migration[5.2]
  def change
    add_column :series, :imdb_id, :string
  end
end
