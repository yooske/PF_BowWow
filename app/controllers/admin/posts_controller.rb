class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @end_user = @post.end_user
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_root_path
  end
end
