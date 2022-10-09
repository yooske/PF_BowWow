class Public::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(6)
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
