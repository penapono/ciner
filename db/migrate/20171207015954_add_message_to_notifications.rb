class AddMessageToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :message, :text
  end
end
