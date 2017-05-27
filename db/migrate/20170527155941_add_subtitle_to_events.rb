class AddSubtitleToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :subtitle, :string
  end
end
