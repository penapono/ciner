class CreateBroadcasts < ActiveRecord::Migration[5.0]
  def change
    create_table :broadcasts do |t|
      t.references :user, index: true

      t.string :title
      t.text :content

      t.boolean :spoiler, default: false
      t.boolean :featured, default: false

      # Reacting
      t.integer :likes_count, default: 0
      t.integer :dislikes_count, default: 0

      # Commenting
      t.integer :comments_count, default: 0

      t.timestamps null: false
    end
  end
end
