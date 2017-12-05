class AddDeletedAtToFilmableProfessionals < ActiveRecord::Migration[5.1]
  def change
    add_column :filmable_professionals, :deleted_at, :datetime
    add_index :filmable_professionals, :deleted_at
  end
end
