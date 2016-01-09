class User < ActiveRecord::Base
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w\+\-\.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
    format: {with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }

  before_save { email.downcase! }
  before_create :create_remember_token

  has_many :shelf_books, dependent: :destroy
  has_many :books, through: :shelf_books, source: :book

  has_many :ratings, dependent: :destroy

  has_many :booklists, dependent: :destroy

  has_many :follow_users, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_follow_users, foreign_key: "followed_id", class_name: "FollowUser", dependent: :destroy
  has_many :fans, through: :reverse_follow_users, source: :follower
  has_many :followeds, through: :follow_users

  has_many :follow_booklists, dependent: :destroy
  has_many :my_focus_booklists, through: :follow_booklists, source: :booklist

  has_many :comments, dependent: :destroy

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  # 书架

  def have_followed_book?(book)
    self.shelf_books.find_by(book_id: book.id)
  end

  def follow_book!(book)
    self.shelf_books.create!(book_id: book.id)
  end

  def unfollow_book!(book)
    self.shelf_books.find_by(book_id: book.id).destroy
  end

  # 评分

  def have_rating_book?(book)
    self.ratings.find_by(book_id: book.id)
  end

  def rating_book!(book, score)
    self.ratings.create!(book_id: book.id, score: score)
  end

  def change_rating_book!(book, score)
    tmp_rating = self.ratings.find_by(book_id: book.id)
    tmp_rating.update_attribute(:score, score)
  end

  def my_rating(book)
    self.ratings.find_by(book_id: book.id).score
  end

  # 关注用户

  def have_followed_person?(user)
    self.follow_users.find_by(followed_id: user.id)
  end

  def follow_person!(user)
    self.follow_users.create!(followed_id: user.id)
  end

  def unfollow_person!(user)
    self.follow_users.find_by(followed_id: user.id).destroy
  end


  # 关注书单

  def have_focused_booklist?(booklist)
    self.follow_booklists.find_by(booklist_id: booklist.id)
  end

  def focus_booklist!(booklist)
    self.follow_booklists.create!(booklist_id: booklist.id)
  end

  def unfocus_booklist!(booklist)
    self.follow_booklists.find_by(booklist_id: booklist.id).destroy
  end


  # 书评

  def make_comment!(book, title, content)
    self.comments.create!(book_id: book.id, title: title, content: content)
  end

  def cancel_comment!(commment)
    self.comments.find(commment.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
