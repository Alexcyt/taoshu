require 'sqlite3'

namespace :db do
  desc "load book data into database"
  task load_book_data: :environment do
    tmp_db = SQLite3::Database.new('./lib/tasks/spider.db')
    res = tmp_db.execute("select book_name, book_author, book_cover, book_src, book_words, book_chapters, book_srcName,
                         book_update, book_new, book_description from Books")
    elem = Hash.new()
    res.each do |e|
      elem[:name] = e[0]
      elem[:author] = e[1]
      elem[:cover] = e[2]
      elem[:source] = e[3]
      elem[:words] = e[4]
      elem[:chapters] = e[5]
      elem[:src_web] = e[6]
      elem[:last_time] = e[7]
      elem[:last_chapter] = e[8]
      elem[:desc] = e[9]
      Book.create!(elem)
    end
  end
end
