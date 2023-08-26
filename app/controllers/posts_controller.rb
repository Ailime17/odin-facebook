class PostsController < ApplicationController

  def new; end

  def create
    respond_to do |format|
      if (@post = current_user.posts.create(post_params))
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('user-posts', @post) }
      else
        flash.now[:error] = "Couldn't create post. Please try again"
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.destroy
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@post) }
      else
        flash.now[:error] = "Couldn't delete post. Please try again"
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @like = Like.find_by(post: @post, user: current_user)
    @delete_rights = current_user.posts.exists?(@post.id)
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
