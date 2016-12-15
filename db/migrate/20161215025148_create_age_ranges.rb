class CreateAgeRanges < ActiveRecord::Migration
  def change
    create_table :age_ranges do |t|
      t.string :name
      t.integer :age

      t.timestamps null: false
    end
  end
end
