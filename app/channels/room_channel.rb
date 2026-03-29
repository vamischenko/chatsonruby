class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = current_user.rooms.find_by(id: params[:room_id])
    if room
      stream_from "room_#{room.id}"
    else
      reject
    end
  end

  def unsubscribed
  end
end
