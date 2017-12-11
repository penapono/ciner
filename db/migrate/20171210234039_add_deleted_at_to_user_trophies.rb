class AddDeletedAtToUserTrophies < ActiveRecord::Migration[5.1]
  def change
    add_column :user_trophies, :deleted_at, :datetime
    add_index :user_trophies, :deleted_at
  end
end
