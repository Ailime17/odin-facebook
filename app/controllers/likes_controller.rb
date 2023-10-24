# frozen_string_literal: true

# controller for liking and unliking posts
class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    respond_to do |f|
      if (@like = @post.likes.create(user: current_user))
        f.turbo_stream { render turbo_stream: turbo_stream.replace(helpers.dom_id(@post, :likes), partial: 'likes/likes', locals: { post: @post, like: @like }) }
      else
        f.html { redirect_to post_path(@post), status: :unprocessable_entity, alert: "Couldn't like post. Please try again" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = Like.find(params[:id])
    respond_to do |f|
      if @like.destroy
        f.turbo_stream { render turbo_stream: turbo_stream.replace(helpers.dom_id(@post, :likes), partial: 'likes/likes', locals: { post: @post, like: nil }) }
      else
        f.html { redirect_to post_path(@post), status: :unprocessable_entity, alert: "Couldn't unlike. Please try again" }
      end
    end
  end
end
