class ShelfBook < ActiveRecord::Base
  validates :user_id, presence: true
  validates :book_id, presence: true

  belongs_to :user
  belongs_to :book

  default_scope -> { order('created_at DESC') }
end
