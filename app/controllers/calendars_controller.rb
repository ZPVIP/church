class CalendarsController < ApplicationController
  load_and_authorize_resource
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  # GET /calendars
  def index
    #@calendars = Calendar.all
    @q = Calendar.search(params[:q])
    @calendars = @q.result.where("depth = 0").order("datum DESC, lft ASC").paginate(:page => params[:page], :per_page => 28)
    @calendars.each{|c|
      tmp_name=''
      tmp_name += '<span class="red">' + c.name + '</span> ';
      c.children.each{ |ch|
        tmp_name += '<span class="green">' + ch.name + ':</span> ';
        if not ch.leaf?
          ch.children.each{|chi|
            tmp_name += chi.name.blank? ? ('<span class="fuchsia">待定</span> '):('<span class="blue">' + chi.name + '</span> ');
          }
        else
          tmp_name += '<span class="fuchsia">待定</span> ';
        end
      }
      c.name = tmp_name
    }
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
    saved = true
    @services = Service.order("lft ASC").roots
    @services.each { |s1|
      @calendar1 = Calendar.new(calendar_params)
      @calendar1.name = s1.title
      @calendar1.parent_id = NIL
      saved &= @calendar1.save!
      if saved && (not s1.leaf?)
        s1.children.each { |s2|
          @calendar2 = Calendar.new(calendar_params)
          @calendar2.name = s2.title
          @calendar2.parent_id = @calendar1.id
          saved &= @calendar2.save!
          if saved && (not s2.leaf?)
            s2.children.each { |s3|
              @calendar3 = Calendar.new(calendar_params)
              @calendar3.name = s3.title
              @calendar3.parent_id = @calendar2.id
              saved &= @calendar3.save!
            }
          end
        }
      end
    }
    saved ? (redirect_to calendars_path, notice: '值日表添加成功。') : (render 'new')
  end

  # PATCH/PUT /calendars/1
  def update
    @calendar.update(calendar_params) ? (redirect_to calendars_path, notice: '值日表更新成功。.') : (render 'edit')
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
    @calendars.each{|c|
      c.destroy if c.root?
    }
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
