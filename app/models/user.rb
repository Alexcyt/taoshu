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

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
