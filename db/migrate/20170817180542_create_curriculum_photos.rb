class CreateCurriculumPhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :curriculum_photos do |t|
      t.references :curriculum, index: true
      t.string :media

      t.timestamps null: false
    end
  end
end
