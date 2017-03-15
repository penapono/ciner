class CreateSerieSeasonEpisodes < ActiveRecord::Migration[5.0]
  def change
    create_table :serie_season_episodes do |t|
      t.references :serie, index: true
      t.references :serie_season, index: true

      t.date :air_date

      t.integer :episode_number

      t.string :name

      t.text :overview

      t.integer :tmdb_id

      t.timestamps null: false
    end
  end
end
