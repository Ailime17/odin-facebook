class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :liking_users, through: :likes, source: :user
  has_many :comments

  validates :body, presence: true
end
