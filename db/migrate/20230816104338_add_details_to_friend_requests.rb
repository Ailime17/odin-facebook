class AddDetailsToFriendRequests < ActiveRecord::Migration[7.0]
  def change
    add_reference :friend_requests, :sender
    add_reference :friend_requests, :receiver
  end
end
