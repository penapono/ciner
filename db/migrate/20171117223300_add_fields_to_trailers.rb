class AddFieldsToTrailers < ActiveRecord::Migration[5.1]
  def change
    change_table :trending_trailers do |t|
      t.references :filmable, polymorphic: true
    end
  end
end
