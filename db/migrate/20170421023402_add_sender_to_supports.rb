class AddSenderToSupports < ActiveRecord::Migration
  def change
    add_column :supports, :message, :string
  end
end
