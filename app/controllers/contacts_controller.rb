class ContactsController < ApplicationController
  before_action :login_required, :admin_required

  def index
    #@contacts = Contact.all
    @q = Contact.search(params[:q])
    @contacts = @q.result.order('id desc').includes(:participated_groups).paginate(:page => params[:page], :per_page => 30)
    respond_to do |format|
      format.json
      format.html          # /app/views/contacts/index.html.erb
      format.html.phone    # /app/views/contacts/index.html+phone.erb
      format.html.pad      # /app/views/contacts/index.html+pad.erb
    end
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
    @contact.update(contact_params) ? (redirect_to contacts_path) : (render :edit)
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to contacts_path(@contact)
  end

  def suchen
    @search = Contact.search(params[:q])
    @contacts = @search.result.includes( :participated_groups)
    p @contacts
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :gender, :telephone, :mobile, :email, :wechat, :address, :birthday, :come, :decision, :decision_with, :baptism, :go,:created_at, :comment,  :q => [], :participated_group_ids => [])
  end
end