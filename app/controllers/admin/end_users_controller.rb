class Admin::EndUsersController < ApplicationController
  def index
    @end_users = EndUser.page(params[:page]).per(10)
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      flash[:notice] = "#{@end_user.name}さんのユーザー情報を更新しました"
      redirect_to admin_end_user_path(@end_user)
    else
      render :edit
    end
  end

  def withdraw
    @end_user = EndUser.find(params[:id])
    # is_deletedカラムをtrueに変更することで削除フラグを立てる
    @end_user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行致しました"
    redirect_to root_path
  end

  private

  def end_user_params
    params.require(:end_user).permit(:profile_image, :name, :nickname, :email, :introduction, :is_deleted)
  end

end
