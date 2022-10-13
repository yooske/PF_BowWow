class Public::SearchesController < ApplicationController
  def search
    @content = params[:content]
    @records = Post.search_for(@content)
  end
end
