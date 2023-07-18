class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: { message: @message })
    )
    redirect_to chatroom_path(@chatroom)
  else
    redirect_to chatroom_path(@chatroom), alert: "Failed to create message"
  end
    authorize @message
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
