class AddNotificationToUsers < ActiveRecord::Migration
  def change
    add_column :supports, :notification, :integer, default: 0
  end
end
