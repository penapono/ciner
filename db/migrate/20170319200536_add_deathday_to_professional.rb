class AddDeathdayToProfessional < ActiveRecord::Migration[5.0]
  def change
    add_column :professionals, :deathday, :date
  end
end
