class Booklist < ActiveRecord::Base
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :desc, presence: true, length: { minimum: 30, maximum: 300 }

  default_scope -> { order('created_at DESC') }

  belongs_to :user

  has_many :follow_booklists, dependent: :destroy

  has_many :list_books, dependent: :destroy
end
