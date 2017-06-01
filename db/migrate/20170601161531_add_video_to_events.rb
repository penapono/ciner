class AddVideoToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :video, :string
    change_column :events, :more, :text
  end
end
