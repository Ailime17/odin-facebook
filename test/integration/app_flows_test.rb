require "test_helper"

class AppFlowsTest < ActionDispatch::IntegrationTest
  test 'can see the log-in page' do
    get '/users/sign_in'
    assert_response :success
    assert_select 'h2', 'Log in'
    assert_select "input[type = 'submit']", 1
  end

  test 'can see the sign-up page' do
    get '/users/sign_up'
    assert_response :success
    assert_select 'h2', 'Sign up'
    assert_select "input[type = 'submit']", 1
  end

  test 'can see the edit user page' do
    log_in users(:one)

    get '/users/edit'
    assert_response :success
    assert_select "input[type = 'submit'][value = 'Update']", 1
  end

  test 'can see the user show page' do
    log_in users(:one)

    get "/users/#{users(:two).id}"
    assert_response :success
    assert_select 'div#user-posts', 1
  end

  test "can see new post form on user's show page (when it's current user's show page)" do
    log_in users(:one)

    get "/users/#{users(:one).id}"
    assert_response :success
    assert_select 'turbo-frame#new_post', 1
  end

  test "can see friend request button on user's show page (when it's not current user's show page)" do
    log_in users(:one)

    get "/users/#{users(:two).id}"
    assert_response :success
    assert_select 'turbo-frame#friend_request', 1
  end

  test 'can see the post show page' do
    log_in users(:one)

    get "/posts/#{posts(:one).id}"
    assert_response :success
    assert_select '.post', 1
  end

  test 'can see the #new post turbo frame page' do
    log_in users(:one)

    get "/users/#{users(:one).id}/posts/new", headers: { 'Turbo-Frame' => 'new_post' }
    assert_response :success
    assert_select 'turbo-frame#new_post', 1
  end

  test 'can see friend request #new button' do
    log_in users(:two)

    get "/users/#{users(:three).id}/friend_requests/new", headers: { 'Turbo-Frame' => 'friend_request' }
    assert_response :success
    assert_select 'turbo-frame#friend_request', 1
  end

  test 'can see friend request #show button' do
    log_in users(:one)

    get "/users/#{users(:three).id}/friend_requests/#{friend_requests(:two).id}", headers: { 'Turbo-Frame' => 'friend_request' }
    assert_response :success
    assert_select 'turbo-frame#friend_request', 1
  end

  test 'can see like button' do
    log_in users(:one)

    get "/posts/#{posts(:two).id}"
    assert_response :success
    assert_select ".like-btn", 1
  end

  test 'can see the #new comment turbo frame page' do
    log_in users(:one)

    get "/posts/#{posts(:two).id}/comments/new", headers: { 'Turbo-Frame' => 'new_comment' }
    assert_response :success
    assert_select 'turbo-frame#new_comment', 1
  end

  test 'can see comments' do
    log_in users(:one)

    get "/posts/#{posts(:two).id}"
    assert_response :success
    assert_select '.comment', 1
  end

  test 'can see notifications' do
    log_in users(:two)

    get "/"
    assert_response :success
    assert_select "#notifications", 1
  end
end
