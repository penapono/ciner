class CreateProfessionals < ActiveRecord::Migration
  def change
    create_table :professionals do |t|
      t.string :name
      t.date :birth
      t.references :country
      t.references :user

      t.references :set_function

      t.timestamps null: false
    end
  end
end
