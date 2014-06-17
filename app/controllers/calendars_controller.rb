class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  # GET /calendars
  # GET /calendars.json
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
            tmp_name += '<span class="blue">' + chi.name + '</span> ';
          }
        end
      }
      c.name = tmp_name
    }
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show

  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
  end

  # GET /calendars/1/edit
  def edit

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
    respond_to do |format|
      format.html { redirect_to calendars_url }
    end
  end

  def add_name
    @calendar = Calendar.new(calendar_params)

    respond_to do |format|
      if @calendar.save
        format.html { redirect_to services_edit_calendars_path(@calendar.datum.to_s), notice: '添加成功！' }
        format.json { render action: 'show', status: :created, location: @calendar }
      else
        format.html { render action: 'new' }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_name
    @calendar = Calendar.find(params[:calendar][:id])
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to services_edit_calendars_path(@calendar.datum.to_s), notice: '更新成功！' }
        format.json { head :no_content }
      else
        format.html { redirect_to services_edit_calendars_path(@calendar.datum.to_s), notice: '更新失败！' }
      end
    end
  end
  # POST /calendars
  # POST /calendars.json
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

    respond_to do |format|
      if saved
        format.html { redirect_to calendars_path, notice: 'Calendar was successfully created.' }
        format.json { render action: 'show', status: :created, location: @calendar }
      else
        format.html { render action: 'new' }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to calendars_path, notice: 'Calendar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    datum = @calendar.datum
    @calendar.destroy
    respond_to do |format|
      format.html { redirect_to services_edit_calendars_path(datum.to_s) }
      format.json { head :no_content }
    end
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
