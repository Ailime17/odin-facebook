# controller for sending, accepting, and taking back sent or accepted friend requests
class FriendRequestsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    if (@friend_request = @user.received_friend_requests.create(sender: current_user))
      redirect_to user_friend_request_path(@user, @friend_request), status: :see_other
    else
      flash.now[:alert] = "Couldn't send friend request. Please try again"
      render new_user_friend_request_path(@user), status: :unprocessable_entity
    end
  end

  def show
    @friend_request = FriendRequest.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def update
    return update_notification if params[:category] == 'notification'

    @friend_request = FriendRequest.find(params[:id])
    @user = User.find(params[:user_id])
    if @friend_request.update(status_id: 2)
      redirect_to user_friend_request_path(@user, @friend_request), status: :see_other
    else
      flash.now[:alert] = "Couldn't accept friend request. Please try again"
      render user_friend_request_path(@user, @friend_request), status: :unprocessable_entity
    end
  end

  def update_notification
    @friend_request = FriendRequest.find(params[:id])
    respond_to do |f|
      if @friend_request.update(status_id: 2)
        f.turbo_stream { render turbo_stream: turbo_stream.update(@friend_request, 'Accepted!') }
      else
        flash.now[:alert] = "Couldn't accept friend request. Please try again"
        f.html { render partial: 'layouts/notif_friend_request', locals: { friend_request: @friend_request }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @user = User.find(params[:user_id])
    if @friend_request.destroy
      redirect_to new_user_friend_request_path(@user), status: :see_other
    else
      flash.now[:alert] = "Couldn't unfriend. Please try again"
      render user_friend_request_path(@user, @friend_request), status: :unprocessable_entity
    end
  end
end
