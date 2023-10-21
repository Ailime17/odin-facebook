class UsersController < ApplicationController
  def show
    @user = params.key?(:id) ? User.find(params[:id]) : current_user
    @user_posts = @user.posts.all.order(:created_at => :desc)
    @friend_request = FriendRequest.where(sender: [current_user, @user]).where(receiver: [current_user, @user]).first
  end
end
