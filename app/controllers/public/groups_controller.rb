class Public::GroupsController < ApplicationController
  def index
    @groups = Group.page(params[:page]).per(10)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_end_user.id
    @group.end_users << current_end_user
    if @group.save
     redirect_to public_groups_path
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @group_chats = @group.group_chats
    @group_chat = GroupChat.new(group_id: @group.id)
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.owner_id == current_end_user.id
      if @group.update(group_params)
        redirect_to public_group_path(@group)
      else
        render :edit
      end
    else
      redirect_to public_groups_path
    end
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.owner_id == current_end_user.id
      @group.destroy
      redirect_to public_groups_path
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_correct_end_user
    @group = Group.find(params[:id])
    unless @group.owner_id ==current_end_user.id
      redirect_to groups_path
    end
  end

end
