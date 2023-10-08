require "test_helper"

class LikeTest < ActiveSupport::TestCase
  setup do
    @like_one = likes(:one)
  end

  test 'Like-User association works properly' do
    @user_one = users(:one)
    assert @like_one.user == @user_one
  end

  test 'Like-Post association works properly' do
    @post_one = posts(:one)
    assert @like_one.post == @post_one
  end
end
