class AddPlaceOfBirthToProfessionals < ActiveRecord::Migration[5.0]
  def change
    add_column :professionals, :place_of_birth, :string
  end
end
