class MessagesController < ApplicationController
  before_action :set_room

  def index
    @rooms = current_user.rooms
    @messages = @room.messages.includes(:user)
    @message = Message.new
  end

  def create
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  private

  def set_room
    @room = current_user.rooms.find_by(id: params[:room_id])
    return if @room

    redirect_to root_path, alert: t('rooms.access_denied', default: 'Комната не найдена или нет доступа.')
  end

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end
