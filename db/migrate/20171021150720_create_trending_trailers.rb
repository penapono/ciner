class CreateTrendingTrailers < ActiveRecord::Migration[5.1]
  def change
    create_table :trending_trailers do |t|
      t.string :title
      t.text :trailer
      t.integer :position

      t.timestamps null: false
    end
  end
end
