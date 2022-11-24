class Admin::ContactsController < ApplicationController
  def show
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update(contact_params)
    flash[:notice] = "対応状況を更新しました"
    redirect_to admin_root_path
  end

  private

  def contact_params
    params.require(:contact).permit(:category, :body, :status)
  end
end
