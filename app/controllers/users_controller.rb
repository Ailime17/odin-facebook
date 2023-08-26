class UsersController < ApplicationController
  def show
    @user = params.key?(:id) ? User.find(params[:id]) : current_user
    @user_posts = @user.posts.all.order(:created_at => :desc)
  end
end
