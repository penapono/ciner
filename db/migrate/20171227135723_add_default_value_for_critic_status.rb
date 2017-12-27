class AddDefaultValueForCriticStatus < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:critics, :status, 2)
  end
end
