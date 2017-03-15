class AddFieldsToSeries < ActiveRecord::Migration[5.0]
  def change
    add_column :series, :number_of_seasons, :integer, default: 1
  end
end
