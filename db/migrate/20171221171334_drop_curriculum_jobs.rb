class DropCurriculumJobs < ActiveRecord::Migration[5.1]
  def change
    drop_table :curriculum_jobs
  end
end
