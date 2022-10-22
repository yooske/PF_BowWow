class Public::EndUsersController < ApplicationController

  def index
    @end_users = EndUser.page(params[:page]).per(10)
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
    if @end_user == current_end_user
      render "edit"
    else
      redirect_to public_end_user_path(@end_user)
    end
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to public_end_user_path(@end_user)
    else
      render :edit
    end
  end

  def destroy
    @end_user = EndUser.find(params[:id])
    @end_user.destroy
    flash[:notice] = "退会処理を実行致しました"
    redirect_to root_path
  end

  def confirm
  end

  def posts
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts.page(params[:page]).per(6)
    #タグを選択して関連する投稿を表示する
    if params[:tag_ids]
      tag_names = []
      params[:tag_ids].each do |key, value|
        tag_names << key if value == "1"
      end
      @posts = @end_user.posts.joins(:tags).where(tags:{name: tag_names}).distinct.page(params[:page]).per(6)
    end
  end

  private

  def end_user_params
    params.require(:end_user).permit(:profile_image, :name, :nickname, :email, :introduction)
  end

end
