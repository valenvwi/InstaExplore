class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]

  def show
    @posts = Post.where(user: @user).order(created_at: :desc)
    @followings = Follow.all.where(follower_id: @user)
    @followers = Follow.all.where(following_id: @user)
    if @user != current_user
      @chatroom = []
      @chatroom1 = Chatroom.find_by(owner_id: current_user, guest_id:@user)
      @chatroom2 = Chatroom.find_by(owner_id: @user, guest_id:current_user)
      @chatrooms = [@chatroom1, @chatroom2]
      @chatrooms.each do |chatroom|
        if chatroom != nil
          @chatroom = chatroom
        end
      end
      @newchatroom = Chatroom.new if @chatroom == [] || @chatroom.nil?
      end
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

  def notification
    @user = current_user
    if current_user
      @notifications = current_user.notifications.order(created_at: :desc)
      @unreadnotifications = []
      @readnotifications = []
      @notifications.each do |notification|
        if notification.read?
          @readnotifications << notification
        else
          @unreadnotifications << notification
        end
      end
      if @unreadnotifications != []
        @unreadnotifications.each do |notification|
        notification.mark_as_read!
        end
      end
    authorize @user
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:avatar, :username, :bio, :location)
  end
end
