require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user_one = users(:one)
  end

  test 'User-Post association works properly' do
    @post_one = posts(:one)
    assert @user_one.posts.exists?(@post_one.id)
    assert @post_one.user == @user_one
  end

  test 'User-Like association works properly' do
    @post_one = posts(:one)
    @like_one = likes(:one)
    assert @user_one.likes.exists?(@like_one.id)
    assert @like_one.user == @user_one
    assert @user_one.liked_posts.exists?(@post_one.id)
  end

  test 'User-Comment association works properly' do
    @comment_one = comments(:one)
    assert @user_one.comments.exists?(@comment_one.id)
    assert @comment_one.user == @user_one
  end

  test 'User-Friend_Request association works properly' do
    @fr_req_one = friend_requests(:one)
    @user_two = users(:two)
    assert @user_one.sent_friend_requests.exists?(@fr_req_one.id)
    assert @user_two.received_friend_requests.exists?(@fr_req_one.id)
    assert @fr_req_one.sender == @user_one && @fr_req_one.receiver == @user_two
  end
end
