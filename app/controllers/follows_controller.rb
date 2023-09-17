class FollowsController < ApplicationController
  before_action :find_user
  before_action :authorize_users, except: %i[followings followers]
  before_action :find_follow, only: [:destroy]

  def followings
    @followings = Follow.where(follower_id: @user.id)
    authorize @followings
  end

  def followers
    @followers = Follow.where(following_id: @user.id)
    authorize @followers
  end

  def create
    @follow = Follow.new
    @follow.following = @user
    @follow.follower = current_user
    @follow.save!
    redirect_to user_path(@user)
  end

  def destroy
    @follow.destroy
    redirect_to user_path(@user)
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def authorize_users
    authorize @user
  end

  def find_follow
    @follow = Follow.find_by(following_id: @user.id, follower_id: current_user.id)
  end
end
