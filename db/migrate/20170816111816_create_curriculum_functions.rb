class CreateCurriculumFunctions < ActiveRecord::Migration[5.1]
  def change
    create_table :curriculum_functions do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
