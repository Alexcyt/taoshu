class ListBook < ActiveRecord::Base
  validates :book_id, presence: true
  validates :booklist_id, presence: true
  validates :score, presence: true
  validates :desc, presence: true, length: { minimum: 30, maximum: 300 }

  default_scope -> { order('created_at DESC') }

  belongs_to :book
  belongs_to :booklist
end
