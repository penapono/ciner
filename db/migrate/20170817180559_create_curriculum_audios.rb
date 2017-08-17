class CreateCurriculumAudios < ActiveRecord::Migration[5.1]
  def change
    create_table :curriculum_audios do |t|
      t.references :curriculum, index: true
      t.string :media

      t.timestamps null: false
    end
  end
end
