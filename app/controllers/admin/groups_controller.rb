class Admin::GroupsController < ApplicationController
  def index
    @groups = Group.page(params[:page]).per(10)
  end

  def show
    @group = Group.find(params[:id])
    @group_chats = @group.group_chats
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path
  end
end
