class CreateSetFunctions < ActiveRecord::Migration
  def change
    create_table :set_functions do |t|
      t.string :name
      t.string :description

      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
