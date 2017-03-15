class CreateSerieSeasons < ActiveRecord::Migration[5.0]
  def change
    create_table :serie_seasons do |t|
      t.references :serie, index: true

      t.string :name

      t.text :overview

      t.date :air_date

      t.integer :tmdb_id

      t.string :poster

      t.integer :season_number

      t.integer :number_of_episodes, default: 0

      t.timestamps null: false
    end
  end
end
