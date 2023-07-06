class LikesController < ApplicationController
  before_action :find_post, :authorize_posts
  before_action :find_like, only: [:destroy]

  def index
    redirect_to post_path(@post)
  end
  def create
    @post.likes.create(user_id: current_user.id)
    redirect_to post_path(@post)
  end

  def destroy
    @like.destroy
    redirect_to post_path(@post)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def authorize_posts
    authorize @post
  end

  def find_like
    @like = @post.likes.find_by(user_id: current_user.id)
  end

end
