class AddFieldsToUserFilmables < ActiveRecord::Migration[5.0]
  def change
    add_column :user_filmables, :media, :integer
    add_column :user_filmables, :version, :integer
  end
end
