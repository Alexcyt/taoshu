class CreateShelfBooks < ActiveRecord::Migration
  def change
    create_table :shelf_books do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps null: false
    end
    add_index :shelf_books, :user_id
    add_index :shelf_books, :book_id
    add_index :shelf_books, [:user_id, :book_id], unique: true
  end
end
