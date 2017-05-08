class AddUserIdToSupports < ActiveRecord::Migration
  def change
    add_column :supports, :user_id, :integer
  end
end
