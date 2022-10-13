class Public::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(6)
    #タグを選択して関連する投稿を表示する
    if params[:tag_ids]

      tag_names = []
      params[:tag_ids].each do |key, value|
        tag_names << key if value == "1"
      end
      @posts = Post.joins(:tags).where(tags:{name: tag_names}).distinct.page(params[:page]).per(6)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save!
      redirect_to public_post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @end_user = @post.end_user
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to public_post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_posts_path
  end

private

  def post_params
    params.require(:post).permit(:title, :body, :image, :video,:name, tag_ids: [])
  end
end
