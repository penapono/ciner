class AddDeletedAtToUserFilmables < ActiveRecord::Migration[5.1]
  def change
    add_column :user_filmables, :deleted_at, :datetime
    add_index :user_filmables, :deleted_at
  end
end
