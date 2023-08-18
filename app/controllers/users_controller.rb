class UsersController < ApplicationController
  def show
    @user = params.key?(:id) ? User.find(params[:id]) : current_user
  end
end
