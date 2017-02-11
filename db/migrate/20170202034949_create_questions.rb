class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.references :user, index: true
      t.references :questionable, polymorphic: true, index: true

      t.string :title
      t.text :content

      t.integer :status, default: 1
      t.integer :origin, default: 2

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
