class FriendRequestStatus < ApplicationRecord
  has_many :friend_requests, foreign_key: 'status_id', class_name: 'FriendRequest'
end
