class Book < ActiveRecord::Base
  has_many :shelf_books, dependent: :destroy

  has_many :ratings, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :list_books, dependent: :destroy
end
