class ContactsController < ApplicationController
  before_action :login_required

  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.save ? (redirect_to contacts_path) : (render :new)
  end


  def edit
    @contact = Contact.find(params[:id])
    @groups = Group.all
  end

  def update
    @contact = Contact.find(params[:id])
    p contact_params
    @contact.update(contact_params) ? (redirect_to contacts_path(@contact)) : (render :edit)
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to contacts_path(@contact)
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :gender, :telephone, :mobile, :email, :address, :birthday, :created_at, :comment, :come, :go, :participated_group_ids => [])
  end
end