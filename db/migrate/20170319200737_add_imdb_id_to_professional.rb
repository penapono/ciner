class AddImdbIdToProfessional < ActiveRecord::Migration[5.0]
  def change
    add_column :professionals, :imdb_id, :integer
  end
end
