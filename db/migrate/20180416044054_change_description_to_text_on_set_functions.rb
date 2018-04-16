class ChangeDescriptionToTextOnSetFunctions < ActiveRecord::Migration[5.2]
  def change
    change_column :set_functions, :description, :text
  end
end
