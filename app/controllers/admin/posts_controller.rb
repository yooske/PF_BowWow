class Admin::PostsController < ApplicationController
  def index
    #1週間分のいいね合計順にsortするための記述
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    posts = Post.all.order(created_at: :desc).sort {|a,b|
    b.favorites.where(created_at: from...to).size <=>
    a.favorites.where(created_at: from...to).size
    }
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(6)
    #タグを選択して関連する投稿を表示する
    if params[:tag_ids]

      tag_names = []
      params[:tag_ids].each do |key, value|
        tag_names << key if value == "1"
      end
      @posts = Post.joins(:tags).where(tags:{name: tag_names}).distinct.page(params[:page]).per(6)
    end
  end

  def show
    @post = Post.find(params[:id])
    @end_user = @post.end_user
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to admin_root_path
  end
end
