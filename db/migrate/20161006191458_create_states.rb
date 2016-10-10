class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :acronym
      t.string :name

      t.references :country, index: true

      t.timestamps null: false
    end
  end
end
