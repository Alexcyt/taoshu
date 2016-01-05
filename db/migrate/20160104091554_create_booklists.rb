class CreateBooklists < ActiveRecord::Migration
  def change
    create_table :booklists do |t|
      t.integer :user_id
      t.string :title
      t.string :content

      t.timestamps null: false
    end
    add_index :booklists, [:user_id, :created_at]
  end
end
