class RemoveDefaultFromNotifications < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:notifications, :created_at, nil)
    change_column_default(:notifications, :updated_at, nil)
  end
end
