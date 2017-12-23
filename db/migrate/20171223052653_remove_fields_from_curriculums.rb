class RemoveFieldsFromCurriculums < ActiveRecord::Migration[5.1]
  def change
    remove_column :curriculums, :winnings1
    remove_column :curriculums, :winnings2
    remove_column :curriculums, :winnings3
    remove_column :curriculums, :winnings4
    remove_column :curriculums, :winnings5
    remove_column :curriculums, :jobs1
    remove_column :curriculums, :jobs2
    remove_column :curriculums, :jobs3
    remove_column :curriculums, :jobs4
    remove_column :curriculums, :jobs5
    remove_column :curriculums, :photo1
    remove_column :curriculums, :photo2
    remove_column :curriculums, :photo3
    remove_column :curriculums, :photo4
    remove_column :curriculums, :photo5
    remove_column :curriculums, :photo6
    remove_column :curriculums, :photo7
    remove_column :curriculums, :photo8
    remove_column :curriculums, :photo9
    remove_column :curriculums, :photo10
    remove_column :curriculums, :video1
    remove_column :curriculums, :video2
    remove_column :curriculums, :video3
    remove_column :curriculums, :audio1
    remove_column :curriculums, :audio2
    remove_column :curriculums, :audio3
    remove_column :curriculums, :file1
    remove_column :curriculums, :file2
    remove_column :curriculums, :file3
    remove_column :curriculums, :curriculum_function_id
  end
end
