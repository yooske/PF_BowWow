class Admin::TagsController < ApplicationController
  def index
    @tag = Tag.new
    @tags = Tag.page(params[:page]).per(10)
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = "タグを作成しました"
      redirect_to admin_tags_path
    else
      @tags = Tag.page(params[:page]).per(10)
      render :index
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      flash[:notice] = "タグを更新しました"
      redirect_to admin_tags_path
    else
      render :edit
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
