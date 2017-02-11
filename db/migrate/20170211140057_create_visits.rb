class CreateVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :visits do |t|
      t.references  :user, index: true
      t.string      :controller
      t.string      :action
      t.string      :path
      t.integer     :resource_id

      t.timestamps null: false
    end
  end
end
