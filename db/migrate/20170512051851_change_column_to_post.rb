class ChangeColumnToPost < ActiveRecord::Migration
  def change
    change_column :posts, :title, :string, null: false
    change_column :posts, :detail, :text, null: false
  end
end
