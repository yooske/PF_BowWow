class Public::GroupChatsController < ApplicationController
  def create
    @group_chat = current_end_user.group_chats.new(group_chat_params)
    render :validater unless @group_chat.save
  end

  private

  def group_chat_params
    params.require(:group_chat).permit(:message, :group_id)
  end
end
