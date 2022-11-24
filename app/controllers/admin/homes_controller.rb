class Admin::HomesController < ApplicationController
  def top
    @contacts = Contact.order(created_at: :desc).page(params[:page]).per(6)
  end
end
