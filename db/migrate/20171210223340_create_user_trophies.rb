class CreateUserTrophies < ActiveRecord::Migration[5.1]
  def change
    create_table :user_trophies do |t|
      t.references :user, index: true
      t.references :trophy, index: true

      t.timestamps null: false
    end
  end
end
