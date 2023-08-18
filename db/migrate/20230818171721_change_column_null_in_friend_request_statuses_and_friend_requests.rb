class ChangeColumnNullInFriendRequestStatusesAndFriendRequests < ActiveRecord::Migration[7.0]
  def change
    change_column_null :friend_requests, :sender_id, false
    change_column_null :friend_requests, :receiver_id, false
    change_column_null :friend_request_statuses, :name, false
  end
end
