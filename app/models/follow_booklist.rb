class FollowBooklist < ActiveRecord::Base
  validates :user_id, presence: true
  validates :booklist_id, presence: true

  belongs_to :user
  belongs_to :booklist

  default_scope -> { order('created_at DESC') }
end
