class UsersController < ApplicationController
  def show
    @visible_user = User.find(params[:id])
  end
end
