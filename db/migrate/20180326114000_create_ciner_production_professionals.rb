class CreateCinerProductionProfessionals < ActiveRecord::Migration[5.1]
  def change
    create_table :ciner_production_professionals do |t|
      t.references :ciner_production, index: true
      t.references :user, index: true
      t.references :curriculum_function, index: true
      t.string :observation

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
