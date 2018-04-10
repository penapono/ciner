class CreateCinerProductionFilmProductionCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :ciner_production_film_production_categories do |t|
      t.references :ciner_production, index: { name: 'cp_index_on_cp' }
      t.references :film_production_category, index: { name: 'fpc_index_on_cp' }
      
      t.datetime :deleted_at
      t.timestamps null: false
    end
  end
end
