class CreateSerieDuplicates < ActiveRecord::Migration[5.1]
  def change
    create_table :serie_duplicates do |t|
      t.text :title
      t.text :available_years
      t.integer :count

      t.timestamps null: false
    end
  end
end
