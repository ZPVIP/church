class ContactsController < ApplicationController
  load_and_authorize_resource
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  after_action :set_birth_month, only: [:create, :update]

  def index
    @q = Contact.search(params[:q])
    @contacts = @q.result.order('authenticated ASC, id DESC').includes(:participated_groups).paginate(:page => params[:page], :per_page => 50)
    respond_to do |format|
      format.json
      format.html # /app/views/contacts/index.html.erb
      format.html.phone # /app/views/contacts/index.html+phone.erb
      format.html.pad # /app/views/contacts/index.html+pad.erb
    end
  end

  def show
  end

  def new
    @contact = Contact.new
    @my_ip = my_ip
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user = current_user
    @contact.save ? (redirect_to contacts_path) : (render :new)
  end


  def edit
    @groups = Group.all
  end

  def update
    unless @contact.updaters.include? current_user; @contact.updaters << current_user;  end
    @contact.update(contact_params) ? (redirect_to contacts_path) : (render :edit)
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path
  end

  def update_month
    #this is an inefficient way 
    #http://guides.rubyonrails.org/active_record_querying.html#retrieving-multiple-objects
    @contacts = Contact.all
    @contacts.each{|c|
      unless c.birthday.nil?
        c.birth_month=c.birthday.month
        c.save!
      end
    }
    redirect_to contacts_path
  end

  # massively import records
  def newimport
  end
  def import
    user_info = {:current_user=> current_user, :ip=>my_ip}
    begin
      file = params[:file]
      raise "Please select a file" unless file.respond_to?(:original_filename) 
      file_ext = File.extname(file.original_filename)
      ci = ContactImporter.new(file.path, extension: file_ext.to_sym, params: user_info)
      import_result=ci.import
      if ci.row_errors.length == 0 and ci.error_msg.empty?
        notice_msg="Import completed!"
      else
        notice_msg= ci.error_msg
      end
    rescue => e
      notice_msg=e.message
      #raise
    ensure
      #redirect_to contacts_path, notice:  notice_msg
      @import_result_msg = notice_msg
      @contacts = Contact.readonly.where(user: current_user, updated_at: 30.seconds.ago..Time.now  ).order('updated_at DESC')
    end
  end
  
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  def set_birth_month
    unless @contact.birthday.nil?
      @contact.birth_month=@contact.birthday.month
      @contact.save!
    end
  end

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
        :birth_month,
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
        :spouse,
        :authenticated,
        :register_ip,
        :q => [],
        :participated_group_ids => [],
        :participated_gathering_ids => []
    )
  end
end