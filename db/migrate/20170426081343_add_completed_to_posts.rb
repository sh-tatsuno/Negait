class AddCompletedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :completed, :integer, default: 0
  end
end
