class CreateUserFilmables < ActiveRecord::Migration[5.0]
  def change
    create_table :user_filmables do |t|
      t.references :user, index: true
      t.references :filmable, polymorphic: true, index: true

      t.integer :action

      t.timestamps null: false
    end
  end
end
