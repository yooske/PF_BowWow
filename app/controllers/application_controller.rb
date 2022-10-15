class ApplicationController < ActionController::Base
  before_action :authenticate_end_user!, if: :public_url, except: [:top, :about]
  before_action :authenticate_admin!, if: :admin_url
  def admin_url
    request.fullpath.include?("/admin")
  end

  def public_url
     request.fullpath.include?("/public")
  end
end
