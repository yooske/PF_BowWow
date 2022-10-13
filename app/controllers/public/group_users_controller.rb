class Public::GroupUsersController < ApplicationController
  #グループに参加する記述
  def create
    group_user = current_end_user.group_users.new(group_id: params[:group_id])
    group_user.save
    redirect_to request.referer
  end
  
  #グループを抜ける記述
  def destroy
    group_user = current_end_user.group_users.find_by(group_id: params[:group_id])
    group_user.destroy
    redirect_to request.referer
  end
end
