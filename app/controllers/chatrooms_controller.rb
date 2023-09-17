class ChatroomsController < ApplicationController
  def index
    @chatrooms = policy_scope(Chatroom).where("owner_id = ? OR guest_id = ?", current_user.id, current_user.id)
    authorize @chatrooms
    @valid_chatrooms = []
    @chatrooms.each do |chatroom|
      if chatroom.messages == []
        chatroom.destroy!
      else
        @valid_chatrooms.push(chatroom)
      end
    end
    @chatrooms = @valid_chatrooms.sort_by { |chatroom| chatroom.messages.last.created_at }.reverse
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    @user = current_user
    authorize @chatroom
    authorize @user
  end

  def create
    @user = User.find(params[:id])
    @chatroom = Chatroom.new
    @chatroom.owner = current_user
    @chatroom.guest = @user
    @chatroom.save
    redirect_to chatroom_path(@chatroom)
    authorize @user
  end
end
