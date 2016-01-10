namespace :db do
  desc "generate user data"
  task get_user_data: :environment do
    make_users
    make_books
    make_booklists
    make_fans
    make_follow_booklist
  end
end

def make_users
  User.create!(name: "我是老大", email: "alexcyt@123.com", password: "111111", password_confirmation: "111111")
  99.times do |n|
    name = "影分身#{n+1}号"
    email = "test#{n+1}@345.com"
    password = "111111"
    User.create!(name: name, email: email, password: password, password_confirmation: password)
  end
end

def make_books
  users = User.all.limit(20)
  i = 0
  users.each do |u|
    c = 25 - i
    i += 1
    books = Book.all.limit(c)
    books.each do |b|
      u.follow_book!(b)
      score = (rand(5)+1)*2
      u.rating_book!(b, score)
      j = rand(4)
      j.times do |k|
        title = "用户#{u.id}评论#{k+1}"
        content = "书#{b.id}是好书, 真好看"*(k+1)*5
        u.make_comment!(b, title, content)
      end
    end
  end
end

def make_booklists
  users = User.all.limit(10)
  users.each do |u|
    booklist_n = rand(15) + 1
    booklist_n.times do |a|
      title = "用户#{u.id}的书单#{a+1}"
      desc = title*10
      tb = u.booklists.create!(title: title, desc: desc)
      book_n = rand(20) + 1
      books = Book.all.limit(book_n)
      books.each do |book|
        score = (rand(5) + 1)*2
        desc = "《#{book.name}》是好书"*8
        tb.list_books.create!(book_id: book.id, score: score, desc: desc)
      end
    end
  end
end

def make_fans
  users = User.all.limit(20)
  users.each do |u|
    n = rand(20) + 5
    other_users = User.all.limit(n)
    other_users.each do |ou|
      if u == ou
        next
      end
      u.follow_person!(ou)
    end
  end
end

def make_follow_booklist
  user =  User.all.limit(30)
  bl = Booklist.all
  user.each do |u|
    bl.each do |b|
      if b.user == u
        next
      end
      if b.id%7 == u.id%7
        u.focus_booklist!(b)
      end
    end
  end
end
