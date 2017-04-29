class RemoveCountryReferenceFromFilmables < ActiveRecord::Migration[5.0]
  def change
    remove_column :movies, :country_id
    remove_column :series, :country_id
  end
end
