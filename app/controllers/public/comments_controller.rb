class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post_id = @post.id
    @comment.end_user_id = current_end_user.id
    render :validater unless @comment.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
