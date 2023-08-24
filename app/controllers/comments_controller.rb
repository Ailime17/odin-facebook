class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), status: :see_other
    else
      flash[:error] = "Couldn't create comment. Please try again"
      redirect_to post_path(@post), status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to post_path(@post), status: :see_other
    else
      flash[:error] = "Couldn't delete comment. Please try again"
      redirect_to post_path(@post), status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
