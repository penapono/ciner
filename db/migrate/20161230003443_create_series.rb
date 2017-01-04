class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :original_title
      t.string :title
      t.integer :year
      t.string :length
      t.text :synopsis
      t.datetime :release
      t.datetime :brazilian_release
      t.references :city
      t.references :state
      t.references :country
      t.references :age_range

      t.string :cover

      t.references :studio

      # Serie

      t.integer :season
      t.integer :number_episodes
      t.integer :aired_episodes

      t.timestamps null: false
    end
  end
end
