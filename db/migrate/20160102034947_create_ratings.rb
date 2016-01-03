class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :score

      t.timestamps null: false
    end
    add_index :ratings, :user_id
    add_index :ratings, :book_id
    add_index :ratings, [:user_id, :book_id], unique: true
  end
end
