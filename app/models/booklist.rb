class Booklist < ActiveRecord::Base
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :desc, presence: true, length: { maximum: 300 }

  default_scope -> { order('created_at DESC') }

  belongs_to :user

  has_many :follow_booklists, dependent: :destroy
end
