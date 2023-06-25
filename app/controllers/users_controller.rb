class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]

  def index
    @user = current_user
    authorize @user
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    # if params[:user][:avatar].present?
    #   uploaded_file = params[:user][:avatar]
    #   cloudinary_response = Cloudinary::Uploader.upload(uploaded_file.tempfile, folder: 'avatars')
    #   @user.avatar = cloudinary_response['secure_url']
    # end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "user was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    authorize @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:avatar, :username, :bio, :location)
  end
end
