class AddTitleToBanners < ActiveRecord::Migration[5.2]
  def change
    add_column :banners, :title, :string
  end
end
