class AddDeletedAtToProfessionals < ActiveRecord::Migration[5.1]
  def change
    add_column :professionals, :deleted_at, :datetime
    add_index :professionals, :deleted_at
  end
end
