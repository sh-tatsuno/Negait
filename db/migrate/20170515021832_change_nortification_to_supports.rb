class ChangeNortificationToSupports < ActiveRecord::Migration
  def change
    rename_column :supports, :notification, :poster_notification
    add_column :supports, :supporter_notification, :integer, default: 0
  end
end
