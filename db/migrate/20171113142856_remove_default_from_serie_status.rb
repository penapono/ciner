class RemoveDefaultFromSerieStatus < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:series, :status, nil)
  end
end
