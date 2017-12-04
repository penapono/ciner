class AddDeletedAtToSeries < ActiveRecord::Migration[5.1]
  def change
    add_column :series, :deleted_at, :datetime
    add_index :series, :deleted_at
  end
end
