class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :book_id
      t.string :title
      t.string :content

      t.timestamps null: false
    end
    add_index :comments, :user_id
    add_index :comments, :book_id
    add_index :comments, [:user_id, :book_id]
  end
end
