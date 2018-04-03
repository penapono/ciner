class CreateCinerProductionVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :ciner_production_videos do |t|
      t.references :ciner_production, index: true
      t.string :video
      t.integer :season
      t.integer :episode
      t.string :observation

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
