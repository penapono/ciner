class CreateCurriculumVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :curriculum_videos do |t|
      t.references :curriculum, index: true
      t.string :media

      t.timestamps null: false
    end
  end
end
