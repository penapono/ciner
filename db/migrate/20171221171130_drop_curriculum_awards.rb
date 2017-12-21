class DropCurriculumAwards < ActiveRecord::Migration[5.1]
  def change
    drop_table :curriculum_awards
  end
end
