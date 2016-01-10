namespace :db do
  desc "save book data into sql"
  task save_book_data: :environment do
    books = Book.all
    i = 1
    books.each do |book|
      file_path = "./lib/tasks/book_dir/#{i}.txt"
      tmp_file = File.new(file_path, "w+")
      i += 1
      str = "#{book.name}|||#{book.author}|||#{book.cover}|||#{book.source}|||#{book.desc}|||#{book.words}|||#{book.chapters}|||#{book.src_web}#{book.last_time}|||#{book.last_chapter}"
      tmp_file.syswrite(str)
      tmp_file.close
    end
  end
end
