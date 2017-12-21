class AddFieldsToCurriculums < ActiveRecord::Migration[5.1]
  def change
    add_column :curriculums, :awards, :string
    add_column :curriculums, :jobs, :string
  end
end
