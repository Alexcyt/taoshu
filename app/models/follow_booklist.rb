class FollowBooklist < ActiveRecord::Base
  validates :user_id, presence: true
  validates :booklist_id, presence: true

  belongs_to :user
  belongs_to :booklist
end
