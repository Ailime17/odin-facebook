# frozen_string_literal: true

class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @profile_picture = @profile.picture if @profile.picture.attached?
  end

  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def update
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @profile.picture.purge if @profile.picture.attached? && params.key?(:picture)
    respond_to do |f|
      if params.key?(:picture) && @profile.picture.attach(safe_params[:picture])
        f.turbo_stream { render turbo_stream: turbo_stream.update('profile_picture', partial: "profile_picture", object: @profile.picture) }
      else
        f.html { render :edit, status: :unprocessable_entity, alert: "Couldn't upload profile picture. Please try again" }
      end
    end
  end

  private

  def safe_params
    params.require(:profile).permit(:picture)
  end

end
