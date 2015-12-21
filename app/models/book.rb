class Book < ActiveRecord::Base
  has_many :shelf_books, dependent: :destroy
end
