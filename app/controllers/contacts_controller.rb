class ContactsController < ApplicationController
  before_action :set_contact, only: %i[edit update]

  def edit; end

  def update
    if @contact.update(contact_params)
      redirect_to @contact.lead, notice: 'Contact was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :active)
  end
end
