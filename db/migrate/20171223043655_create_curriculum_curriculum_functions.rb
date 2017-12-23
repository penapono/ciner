class CreateCurriculumCurriculumFunctions < ActiveRecord::Migration[5.1]
  def change
    create_table :curriculum_curriculum_functions do |t|
      t.references :curriculum, index: true
      t.references :curriculum_function, index: true

      t.timestamps null: false
    end
  end
end
