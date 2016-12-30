class CreateCinerVideos < ActiveRecord::Migration
  def change
    create_table :ciner_videos do |t|
      t.string :original_title
      t.string :title
      t.integer :year
      t.integer :length
      t.text :synopsis
      t.datetime :release
       t.datetime :brazilian_release
      t.references :city
      t.references :state
      t.references :country
      t.references :age_range

      t.string :cover

      t.references :studio

      # Ciner Movie

      t.date :approval
      t.references :user, :approver
      t.references :user, :owner

      t.timestamps null: false
    end
  end
end
