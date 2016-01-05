class CreateFollowBooklists < ActiveRecord::Migration
  def change
    create_table :follow_booklists do |t|
      t.integer :user_id
      t.integer :booklist_id

      t.timestamps null: false
    end
    add_index :follow_booklists, :user_id
    add_index :follow_booklists, :booklist_id
    add_index :follow_booklists, [:user_id, :booklist_id], unique: true
  end
end
