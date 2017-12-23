class ChangeHeightFieldOnCurriculums < ActiveRecord::Migration[5.1]
  def change
    change_column :curriculums, :height, :float
  end
end
