class ChangeSetFunctionToCurriculumFunctionOnCurriculum < ActiveRecord::Migration[5.1]
  def change
    remove_column :curriculums, :set_function_id
    add_reference :curriculums, :curriculum_function, index: true
  end
end
