class CreateCinerNews < ActiveRecord::Migration
  def change
    create_table :ciner_news do |t|
      t.references :user, index: true
      t.references :city
      t.references :state
      t.references :country

      t.string :name
      t.text :content

      t.timestamps null: false
    end
  end
end
