class ChangePosterToSupports < ActiveRecord::Migration
  def change
    change_column :supports, :poster_notification, :integer, default: 1
  end
end
