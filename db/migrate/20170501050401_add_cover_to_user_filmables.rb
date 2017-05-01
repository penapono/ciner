class AddCoverToUserFilmables < ActiveRecord::Migration[5.0]
  def change
    add_column :user_filmables, :cover, :string
  end
end
