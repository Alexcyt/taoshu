class AddColumnToBooks < ActiveRecord::Migration
  def change
    add_column :books, :words, :string
    add_column :books, :chapters, :string
    add_column :books, :src_web, :string
    add_column :books, :last_time, :string
    add_column :books, :last_chapter, :string
  end
end
