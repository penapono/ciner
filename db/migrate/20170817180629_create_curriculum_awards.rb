class CreateCurriculumAwards < ActiveRecord::Migration[5.1]
  def change
    create_table :curriculum_awards do |t|
      t.references :curriculum, index: true
      t.string :category
      t.string :title

      t.timestamps null: false
    end
  end
end
