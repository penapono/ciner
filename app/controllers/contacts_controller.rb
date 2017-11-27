# frozen_string_literal: true

class ContactsController < ApplicationController
  include ContactsBreadcrumb

  PERMITTED_PARAMS = %i[
    name
    email
    subject
    message
  ].freeze

  expose(:contact, attributes: :contact_attributes)

  def create
    contact = Contact.new(contact_attributes)
    if contact.save
      ContactMailer.contact_email('pedro.gnaponoceno@gmail.com', contact).deliver
      redirect_to_index_with_success
    else
      render_new_with_error
    end
  end

  private

  def resource
    contact
  end

  def resource_title
    contact.message
  end

  def index_path
    root_path
  end

  def resource_params
    params.require(:contact).permit(PERMITTED_PARAMS)
  end

  def contact_attributes
    params.require(:contact).permit(:name, :email, :subject, :message)
  end
end
