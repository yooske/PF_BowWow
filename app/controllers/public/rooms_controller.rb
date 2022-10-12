class Public::RoomsController < ApplicationController
  def index
    current_user_rooms = current_end_user.user_rooms
    my_room_id = []
    current_user_rooms.each do |user_room|
      my_room_id << user_room.room_id
    end
    #user_roomテーブルからmy_room_idでend_user_idが自分のIDでないレコードを取得
    @another_user_rooms = UserRoom.where(room_id: my_room_id).where.not(end_user_id: current_end_user.id)
  end
end
