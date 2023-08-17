class CreateFriendRequestStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_request_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
