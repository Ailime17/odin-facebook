require "test_helper"

class FriendRequestTest < ActiveSupport::TestCase
  setup do
    @fr_req_one = friend_requests(:one)
  end

  test 'Friend_Request-User association works properly' do
    @user_one = users(:one)
    @user_two = users(:two)
    assert @fr_req_one.sender == @user_one && @fr_req_one.receiver == @user_two
  end

  test 'Friend_Request-Friend_Request_Status association works properly' do
    @fr_req_status_one = friend_request_statuses(:one)
    assert @fr_req_one.status == @fr_req_status_one
    #and a quick test for FriendRequestStatus model:
    assert @fr_req_status_one.friend_requests.exists?(@fr_req_one.id)
  end
end
