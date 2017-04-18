class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.integer  :poster_or_supporter
      t.integer  :support_id
      t.text  :talk
      t.timestamps null: false　
    end
  end
end
