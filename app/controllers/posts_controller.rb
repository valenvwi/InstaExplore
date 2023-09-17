class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]
  skip_after_action :verify_authorized, only: %i[index show nearby following search]
  after_action :authorize_posts, only: %i[show new edit create update destroy]

  def index
    @pagy, @posts = pagy(policy_scope(Post).order(created_at: :desc), items: 10)
    if user_signed_in?
      @comment = Comment.new
    else
      redirect_to new_user_session_path
    end
  end

  def following
    @follows = Follow.where(follower_id: current_user.id)
    @posts = Post.where(user_id: @follows.pluck(:following_id)).order(created_at: :desc)
    @pagy, @posts = pagy(@posts, items: 10)
  end

  def nearby
    @posts = policy_scope(Post).near(current_user.location, 100).order(created_at: :desc)
    @pagy, @posts = pagy(@posts, items: 10)
  end

  def search
    if params[:query].present?
      sql_subquery = <<~SQL
        posts.title ILIKE :query
        OR posts.description ILIKE :query
        OR posts.location ILIKE :query
      SQL
      @posts = Post.where(sql_subquery, query: "%#{params[:query]}%").order(created_at: :desc)
      if @posts.any?
        @pagy, @posts = pagy(@posts, items: 10)
      else
        @pagy = Pagy.new(count: 0, items: 10)
      end
    else
      @posts = []
    end
  end

  def show
    if user_signed_in?
      @comment = Comment.new
    else
      redirect_to new_user_session_path
    end
  end

  def new
    @post = Post.new
  end

  def edit
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: "post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :location, images: [])
  end

  def authorize_posts
    authorize @post
  end
end
