class AddFeaturedToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :featured, :boolean, default: false
  end
end
