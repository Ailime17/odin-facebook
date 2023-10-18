class FriendRequestsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    if @user.received_friend_requests.create(sender: current_user)
      redirect_back_or_to root_path, status: :see_other
    else
      flash[:alert] = "Couldn't send friend request. Please try again"
      redirect_back_or_to root_path, status: :unprocessable_entity
    end
  end

  def update
    @friend_request = FriendRequest.find(params[:id])
    if @friend_request.update(status_id: 2)
      redirect_back_or_to root_path, status: :see_other
    else
      flash[:alert] = "Couldn't accept friend request. Please try again"
      redirect_back_or_to root_path, status: :unprocessable_entity
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    if @friend_request.destroy
      redirect_back_or_to root_path, status: :see_other
    else
      flash[:alert] = "Couldn't unfriend. Please try again"
      redirect_back_or_to root_path, status: :unprocessable_entity
    end
  end
end
