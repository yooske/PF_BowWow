class Public::ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.end_user_id = current_end_user.id
    if @contact.save
      redirect_to complete_public_contacts_path
    else
      render :new
    end
  end

  def complete
  end

  def index
  end

  private

  def contact_params
    params.require(:contact).permit(:category, :body, :status)
  end
end
