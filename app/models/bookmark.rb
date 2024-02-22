class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :movie_id, presence: true
  validates :list_id, presence: true
  validates :movie_id, uniqueness: { scope: :list_id, message: 'This movie already exists in this list' }
  validates :comment, length: { minimum: 6, message: 'Comment minimum length is 6 character' }
end
