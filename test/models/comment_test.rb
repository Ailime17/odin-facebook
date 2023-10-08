require "test_helper"

class CommentTest < ActiveSupport::TestCase
  setup do
    @comment_one = comments(:one)
  end

  test 'Comment-User association works properly' do
    @user_one = users(:one)
    assert @comment_one.user == @user_one
  end

  test 'Comment-Post association works properly' do
    @post_one = posts(:one)
    assert @comment_one.post == @post_one
  end
end
