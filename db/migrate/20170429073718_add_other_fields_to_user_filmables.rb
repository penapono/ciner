class AddOtherFieldsToUserFilmables < ActiveRecord::Migration[5.0]
  def change
    add_column :user_filmables, :store, :string
    add_column :user_filmables, :gift, :boolean
    add_column :user_filmables, :price, :float
    add_column :user_filmables, :bought, :date
    add_column :user_filmables, :isbn, :string
    add_column :user_filmables, :borrowed, :string
    add_column :user_filmables, :observation, :string
  end
end
