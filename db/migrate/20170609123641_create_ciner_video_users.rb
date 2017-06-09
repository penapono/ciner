class CreateCinerVideoUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :ciner_video_users do |t|
      t.references :ciner_video, index: false

      t.references :set_function, index: false
      t.references :user, index: false

      t.timestamps null: false
    end
  end
end
