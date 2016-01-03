class Book < ActiveRecord::Base
  has_many :shelf_books, dependent: :destroy

  has_many :ratings, dependent: :destroy
  has_many :all_ratings, through: :ratings, source: :book

end
