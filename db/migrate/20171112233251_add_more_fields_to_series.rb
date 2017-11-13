class AddMoreFieldsToSeries < ActiveRecord::Migration[5.1]
  def change
    add_column :series, :status, :integer, default: 0
  end
end
