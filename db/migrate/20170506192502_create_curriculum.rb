class CreateCurriculum < ActiveRecord::Migration[5.0]
  def change
    create_table :curriculums do |t|
      # User Attributes
      t.string :play_name
      t.string :avatar
      t.text :biography

      # Professional Attributes
      t.references :set_function

      # If Professional is an User
      t.references :user

      # Measures
      t.integer :mannequin
      t.float :height
      t.integer :ethnicity

      t.boolean :drt
      t.string :winnings1
      t.string :winnings2
      t.string :winnings3
      t.string :winnings4
      t.string :winnings5
      t.string :jobs1
      t.string :jobs2
      t.string :jobs3
      t.string :jobs4
      t.string :jobs5
      t.string :photo1
      t.string :photo2
      t.string :photo3
      t.string :photo4
      t.string :photo5
      t.string :photo6
      t.string :photo7
      t.string :photo8
      t.string :photo9
      t.string :photo10
      t.string :video1
      t.string :video2
      t.string :video3
      t.string :audio1
      t.string :audio2
      t.string :audio3
      t.string :file1
      t.string :file2
      t.string :file3

      t.timestamps null: false
    end
  end
end
