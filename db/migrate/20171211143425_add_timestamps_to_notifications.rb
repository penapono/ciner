class AddTimestampsToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :created_at, :datetime, null: false, default: DateTime.now
    add_column :notifications, :updated_at, :datetime, null: false, default: DateTime.now
  end
end
