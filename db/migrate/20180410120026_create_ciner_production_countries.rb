class CreateCinerProductionCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :ciner_production_countries do |t|
      t.references :ciner_production, index: true
      t.references :country, index: true

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
