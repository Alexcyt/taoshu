class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :cover
      t.string :source
      t.string :desc

      t.timestamps null: false
    end
  end
end
