class AddRingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ring, :integer, default: 0
  end
end
