class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
      t.integer  :post_id
      t.integer  :supporter_id
      t.string  :message
      t.timestamps null: false
    end
  end
end
