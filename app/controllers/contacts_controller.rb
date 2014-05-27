class ContactsController < ApplicationController
  load_and_authorize_resource

  def index
    #@contacts = Contact.all
    @q = Contact.search(params[:q])
    @contacts = @q.result.order('id desc').includes(:participated_groups).paginate(:page => params[:page], :per_page => 30)
    respond_to do |format|
      format.json
      format.html # /app/views/contacts/index.html.erb
      format.html.phone # /app/views/contacts/index.html+phone.erb
      format.html.pad # /app/views/contacts/index.html+pad.erb
    end
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
    @my_ip = my_ip
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
    @contact.update(contact_params) ? (redirect_to contacts_path) : (render :edit)
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to contacts_path(@contact)
  end

  private

  def contact_params
    params.require(:contact).permit(
        :name,
        :gender,
        :telephone,
        :mobile,
        :email,
        :wechat,
        :address,
        :birthday,
        :come,
        :decision,
        :decision_with,
        :baptism,
        :go,
        :created_at,
        :comment,
        :job,
        :find_us,
        :find_us_additional,
        :friend_id,
        :pray,
        :native_place,
        :authenticated,
        :register_ip,
        :q => [],
        :participated_group_ids => [],
        :participated_gathering_ids => []
    )
  end
end