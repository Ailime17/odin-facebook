require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @post_one = posts(:one)
  end

  test 'Post-User association works properly' do
    @user_one = users(:one)
    assert @post_one.user == @user_one
  end

  test 'Post-Like association works properly' do
    @like_one = likes(:one)
    assert @post_one.likes.exists?(@like_one.id)
    @user_one = users(:one)
    assert @post_one.liking_users.exists?(@user_one.id)
  end

  test 'Post-Comment association works properly' do
    @comment_one = comments(:one)
    assert @post_one.comments.exists?(@comment_one.id)
  end
end
