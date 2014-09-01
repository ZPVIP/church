class CalendarsController < ApplicationController
  load_and_authorize_resource
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  # GET /calendars
  def index
    #@calendars = Calendar.all
    @q = Calendar.search(params[:q])
    @calendars = @q.result.where("depth = 0").order("datum DESC, lft ASC").paginate(:page => params[:page], :per_page => 28)
    @tmp_report = ''
    tmp_str = ''

    unless params[:q].blank?
      @tmp_report += '聚会时间：' + @calendars.first.datum.year.to_s + '年' + @calendars.first.datum.month.to_s + '月' + @calendars.first.datum.day.to_s + '日 周六15:00-17:30&#13;&#10;聚会地点：3号房间，FeG Roermonder Straße 110，52062 Aachen&#13;&#10;&#13;&#10;'
      @calendars.each do |c|
        c.children.each do |ch|
          if not ch.leaf?
            ch.children.each do |chi|
              unless chi.name.blank?
                tmp_str = c.name + ch.name + ': ' +  chi.name + '&#13;&#10;'
                @tmp_report += tmp_str
              end
            end
          end
        end
        @tmp_report += '&#13;&#10;' unless tmp_str.blank?
        tmp_str = ''
      end
    end

    @calendars.each do |c|
      tmp_name=''
      tmp_name += '<span class="red">' + c.name + '</span> '
      c.children.each do |ch|
        tmp_name += '<span class="green">' + ch.name + ':</span> '
        if not ch.leaf?
          ch.children.each do|chi|
            tmp_name += chi.name.blank? ? ('<span class="fuchsia">未填</span> '):('<span class="blue">' + chi.name + '</span> ');
          end
        else
          tmp_name += '<span class="fuchsia">未填</span> ';
        end
      end
      c.name = tmp_name
    end
  end

  # GET /calendars/1
  def show
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
  end

  # GET /calendars/1/edit
  def edit
  end

  # POST /calendars
  def create
    if Calendar.where(datum: params[:calendar][:datum]).blank?
      saved = true
      @services = Service.order("lft ASC").roots
      @services.each do |s1|
        @calendar1 = Calendar.new(calendar_params)
        @calendar1.name = s1.title
        @calendar1.parent_id = NIL
        saved &= @calendar1.save!
        if saved && (not s1.leaf?)
          s1.children.each do |s2|
            @calendar2 = Calendar.new(calendar_params)
            @calendar2.name = s2.title
            @calendar2.parent_id = @calendar1.id
            saved &= @calendar2.save!
            if saved && (not s2.leaf?)
              s2.children.each do |s3|
                @calendar3 = Calendar.new(calendar_params)
                @calendar3.name = s3.title
                @calendar3.parent_id = @calendar2.id
                saved &= @calendar3.save!
              end
            end
          end
        end
      end
      saved ? (redirect_to calendars_path, notice: '值日表添加成功。') : (render 'new')
    else
      redirect_to calendars_path, alert: '这天的值日表已经存在。'
    end
  end

  # PATCH/PUT /calendars/1
  def update
    @calendar.update(calendar_params) ? (redirect_to services_edit_calendars_path(@calendar.datum.to_s), notice: '值日表项目成功。.') : (render edit_calendar_path(@calendar))
  end

  # DELETE /calendars/1
  def destroy
    datum = @calendar.datum
    @calendar.destroy
    redirect_to services_edit_calendars_path(datum.to_s)
  end


  def services_edit
    @calendars = Calendar.where(datum: params[:datum]).order('lft')
    @calendar = Calendar.new
  end

  def services_delete
    @calendars = Calendar.where(datum: params[:datum])
    @calendars.each do |c|
      c.destroy if c.root?
    end
    redirect_to calendars_url
  end

  def add_name
    @calendar = Calendar.new(calendar_params)
    @calendar.save ? (redirect_to services_edit_calendars_path(@calendar.datum.to_s), notice: '添加成功！') : (render 'new')
  end

  def update_name
    @calendar = Calendar.find(params[:calendar][:id])
    @calendar.update(calendar_params) ? (redirect_to services_edit_calendars_path(@calendar.datum.to_s), notice: '更新成功！') : (redirect_to services_edit_calendars_path(@calendar.datum.to_s), notice: '更新失败！')
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_calendar
    @calendar = Calendar.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def calendar_params
    params.require(:calendar).permit(:id, :datum, :name, :parent_id, :lft, :rgt, :depth, :q => [])
  end
end
