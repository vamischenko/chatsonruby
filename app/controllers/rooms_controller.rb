class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  def create
    permitted = room_params
    @room = Room.new(name: permitted[:name])
    user_ids = Array(permitted[:user_ids]).reject(&:blank?).map(&:to_i)
    user_ids |= [current_user.id]
    @room.user_ids = user_ids.uniq

    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @rooms = current_user.rooms
  end

  def destroy
    @room = current_user.rooms.find(params[:id])
    @room.destroy
    redirect_to root_path
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: t('rooms.access_denied', default: 'Комната не найдена или нет доступа.')
  end

  private

  def room_params
    params.require(:room).permit(:name, user_ids: [])
  end
end
