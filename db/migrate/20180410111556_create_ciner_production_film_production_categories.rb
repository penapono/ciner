class CreateCinerProductionFilmProductionCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :ciner_production_film_production_categories do |t|
      t.references :ciner_production, index: true
      t.references :film_production_category, index: true
      
      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
