class PostsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    if @user.posts.create(post_params)
      redirect_back_or_to root_path, status: :see_other
    else
      flash[:error] = "Couldn't create post. Please try again"
      redirect_back_or_to root_path, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_back_or_to root_path, status: :see_other
    else
      flash[:error] = "Couldn't delete post. Please try again"
      redirect_back_or_to root_path, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
