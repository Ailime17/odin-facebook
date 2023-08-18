class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :status, class_name: 'FriendRequestStatus'

  scope :pending, -> { where(status_id: 1) }
  scope :accepted, -> { where(status_id: 2) }
end
