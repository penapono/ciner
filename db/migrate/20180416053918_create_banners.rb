class CreateBanners < ActiveRecord::Migration[5.2]
  def change
    create_table :banners do |t|
      t.string :link
      t.string :image
      t.boolean :visible
      t.integer :position

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
