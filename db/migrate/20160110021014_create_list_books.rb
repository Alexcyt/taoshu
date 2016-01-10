class CreateListBooks < ActiveRecord::Migration
  def change
    create_table :list_books do |t|
      t.integer :book_id
      t.integer :booklist_id
      t.integer :score
      t.string :desc

      t.timestamps null: false
    end
    add_index :list_books, :book_id
    add_index :list_books, :booklist_id
    add_index :list_books, [:book_id, :booklist_id], unique: true
  end
end
