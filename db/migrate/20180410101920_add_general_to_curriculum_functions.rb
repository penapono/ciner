class AddGeneralToCurriculumFunctions < ActiveRecord::Migration[5.1]
  def change
    add_column :curriculum_functions, :general, :string
  end
end
