class Public::HomesController < ApplicationController
  before_action :authenticate_end_user!, if: :public_url, except: [:top, :about, :guest_sign_in]
  def top
     #登録日が最新の投稿3つを代入
    @posts = Post.order(created_at: :desc).limit(3)
  end

  def about
  end

  def guest_sign_in
    end_user = EndUser.find_or_create_by!(email: 'guest@example.com') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.name = "ゲスト"
      end_user.nickname = "ゲスト"
      end_user.introduction = "ゲスト"
    end
    sign_in end_user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
