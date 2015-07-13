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
    if params[:contact][:unknown_year]
      params[:contact]["birthday(1i)"]=1900.to_s
    end
    if params[:contact][:unknown_birthday]
      params[:contact]["birthday(1i)"]=1900.to_s
      params[:contact]["birthday(2i)"]=1.to_s
      params[:contact]["birthday(3i)"]=1.to_s
    end
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
    #http://guides.rubyonrails.org/active_record_querying.html#retrieving-multiple-objects
    Contact.find_each(batch_size: 100) do |c|
      if c.unknown_birthday
        c.update_attribute(:birth_month, 0)
      elsif !c.birthday.nil?
        c.update_attribute(:birth_month, c.birthday.month)
      end
    end
    redirect_to contacts_path
  end

  # massively import records
  def import
    user_info = {:current_user=> current_user, :ip=>my_ip}
    begin
      file = params[:file]
      raise '请选择一个要上传的文件！' unless file.respond_to?(:original_filename)
      file_ext = File.extname(file.original_filename)
      ci = ContactImporter.new(file.path, extension: file_ext.to_sym, params: user_info)
      import_result=ci.import
      if ci.row_errors.length == 0 and ci.error_msg.empty?
        flash[:notice]= "祝贺你，所有数据都成功导入了！<br>请在联系人列表中逐个编辑用红色背景标记的联系人。<br>检查无误后，请在“审核”一栏打勾，并提交修改。"
      else
        flash[:error]= ci.error_msg
      end
    rescue => e
      flash[:error]= e.message
      #raise
    ensure
      @contacts = Contact.readonly.where(user: current_user, updated_at: 30.seconds.ago..Time.now  ).order('updated_at DESC')
    end
  end
  
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  def set_birth_month
    if @contact.unknown_birthday
      @contact.birth_month=0
      @contact.save!
    elsif !@contact.birthday.nil?
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
        :unknown_year,
        :unknown_birthday,
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