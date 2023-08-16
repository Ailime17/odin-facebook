class FriendRequestsController < ApplicationController
  def create
    @user = User.find(permitted_params[:receiver_id])
    friend_request = @user.received_friend_requests.build
    friend_request.sender = current_user
    friend_request.save
    redirect_back_or_to root_path
  end

  def permitted_params
    params.require(:friend_request).permit(:receiver_id)
  end
end
