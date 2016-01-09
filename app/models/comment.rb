class Comment < ActiveRecord::Base
  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { minimum: 30, maximum: 300 }

  default_scope -> { order('created_at DESC') }

  belongs_to :user
  belongs_to :book

end
