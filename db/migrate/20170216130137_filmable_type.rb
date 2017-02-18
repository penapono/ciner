class FilmableType < ActiveRecord::Migration[5.0]
  def change
  	create_table :filmable_type do |t|
      t.references :filmable, polymorphic: true, index: true
	  t.references :film_production_categories
	  t.string :filmable_type    
    end
  end
end
