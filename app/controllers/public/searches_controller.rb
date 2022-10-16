class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!, if: :public_url, except: [:search]

  def search
    @content = params[:content]
    @records = Post.search_for(@content).page(params[:page]).per(6)
  end
end
