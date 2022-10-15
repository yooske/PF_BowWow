class Public::ChatsController < ApplicationController
  before_action :authenticate_end_user!
  def show
    @end_user = EndUser.find(params[:id])
    rooms = current_end_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(end_user_id: @end_user.id, room_id: rooms)

    #user_roomがない場合、作成する
    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(end_user_id: current_end_user.id, room_id: @room.id)
      UserRoom.create(end_user_id: @end_user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_end_user.chats.new(chat_params)
    render :validater unless @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end
