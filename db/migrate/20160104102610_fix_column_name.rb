class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :booklists, :content, :desc
  end
end
