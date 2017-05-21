class AddComplexFieldsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :cover, :string
    add_column :events, :place, :string
    add_column :events, :more, :text
  end
end
