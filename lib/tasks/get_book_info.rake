namespace :db do
  desc "get book data from txt"
  task get_book_data: :environment do
    dir_path = "./lib/tasks/book_dir/"
    Dir::foreach(dir_path) do |path|
      if path != "." && path != ".."
        file_path = dir_path + path
        tmp_file = File.new(file_path, "r")
        str = ""
        tmp_file.each_line { |line| str += line }
        tmp_file.close
        res = str.split("|||")
        elems = Hash.new
        elems[:name] = res[0]
        elems[:author] = res[1]
        elems[:cover] = res[2]
        elems[:source] = res[3]
        elems[:desc] = res[4]
        elems[:words] = res[5]
        elems[:chapters] = res[6]
        elems[:src_web] = res[7]
        elems[:last_time] = res[8]
        elems[:last_chapter] = res[9]
        Book.create!(elems)
      end
    end
  end
end
