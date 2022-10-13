class Public::HomesController < ApplicationController
  def top
     #登録日が最新の投稿3つを代入
    @posts = Post.order(created_at: :desc).limit(3)
  end

  def about
  end
end
