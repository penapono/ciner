class CreateFilmProductions < ActiveRecord::Migration
  def change
    create_table :film_productions do |t|
      t.string :original_title
      t.string :title
      t.integer :year
      t.integer :length
      t.references :film_production_category
      t.text :synopsis
      t.datetime :release
      t.datetime :brazilian_release
      t.references :country
      t.references :age_range

      t.string :cover

      # Movie / Serie / CinerMovie

      t.integer :type

      # Movie

      t.references :studio

      # Ciner Movie

      t.date :approval
      t.references :user, :approver
      t.references :user, :owner

      # Serie

      t.integer :season
      t.integer :number_episodes
      t.integer :aired_episodes

      t.timestamps null: false
    end
  end
end
