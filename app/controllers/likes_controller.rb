# controller for liking and unliking posts
class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    if @post.likes.create(user: current_user)
      redirect_back_or_to root_path, status: :see_other
    else
      flash[:error] = "Couldn't like post. Please try again"
      redirect_back_or_to root_path, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    @like = Like.find_by(post: post, user: current_user)
    if @like.destroy
      redirect_back_or_to root_path, status: :see_other
    else
      flash[:error] = "Couldn't unlike. Please try again"
      redirect_back_or_to root_path, status: :unprocessable_entity
    end
  end
end
