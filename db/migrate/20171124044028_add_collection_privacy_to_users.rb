class AddCollectionPrivacyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :collection_privacy, :integer, default: 0
  end
end
