class ChangeDetailsInFriendRequests < ActiveRecord::Migration[7.0]
  def change
    change_column_default :friend_requests, :friend_request_status_id, from: nil, to: 1
    rename_column :friend_requests, :friend_request_status_id, :status_id
  end
end
