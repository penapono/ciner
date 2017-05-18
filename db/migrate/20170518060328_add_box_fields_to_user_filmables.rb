class AddBoxFieldsToUserFilmables < ActiveRecord::Migration[5.0]
  def change
    add_column :user_filmables, :box, :boolean, default: false
    add_column :user_filmables, :box_title, :string
  end
end
