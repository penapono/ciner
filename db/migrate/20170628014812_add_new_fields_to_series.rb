class AddNewFieldsToSeries < ActiveRecord::Migration[5.0]
  def change
    add_column :series, :last_released, :boolean, default: false
    add_column :series, :playing_soon, :boolean, default: false
    add_column :series, :available_netflix, :boolean, default: false
    add_column :series, :available_amazon, :boolean, default: false
  end
end
