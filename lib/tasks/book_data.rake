require 'sqlite3'

namespace :db do
  desc "load book data into database"
  task load_book_data: :environment do
    tmp_db = SQLite3::Database.new('./lib/tasks/spider.db')
    res = tmp_db.execute("select book_name, book_author, book_cover, book_src, book_des from Books")
    elem = Hash.new()
    res.each do |e|
      elem[:name] = e[0]
      elem[:author] = e[1]
      elem[:cover] = e[2]
      elem[:source] = e[3]
      elem[:desc] = e[4]
      Book.create!(elem)
    end
  end
end
