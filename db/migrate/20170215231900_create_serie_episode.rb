class CreateSerieEpisode < ActiveRecord::Migration[5.0]
  def change
    create_table :serie_episodes do |t|
      t.references :series
      t.string :original_title_ep
      t.string :title_ep
      t.integer :year
      t.string :length
      t.text :synopsis
      t.date :release
      t.date :brazilian_release
      t.references :city
      t.references :state
      t.references :country
      t.references :age_range

      t.string :cover

      t.references :studio

      # Serie episode

      t.integer :season
      t.integer :episode_number

      t.timestamps null: false
    end
  end
end
