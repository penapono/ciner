class CreateCurriculumJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :curriculum_jobs do |t|
      t.references :curriculum, index: true
      t.string :description

      t.timestamps null: false
    end
  end
end
