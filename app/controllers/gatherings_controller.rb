class GatheringsController < ApplicationController
  before_action :set_gathering, only: [:show, :edit, :update, :destroy]

  # GET /gatherings
  # GET /gatherings.json
  def index
    @gatherings = Gathering.all
  end

  # GET /gatherings/new
  def new
    @gathering = Gathering.new
  end

  # GET /gatherings/1/edit
  def edit
  end

  # POST /gatherings
  # POST /gatherings.json
  def create
    @gathering = Gathering.new(gathering_params)

    respond_to do |format|
      if @gathering.save
        format.html { redirect_to gatherings_path, notice: 'Gathering was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /gatherings/1
  # PATCH/PUT /gatherings/1.json
  def update
    respond_to do |format|
      if @gathering.update(gathering_params)
        format.html { redirect_to gatherings_path, notice: 'Gathering was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /gatherings/1
  # DELETE /gatherings/1.json
  def destroy
    @gathering.destroy
    respond_to do |format|
      format.html { redirect_to gatherings_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gathering
      @gathering = Gathering.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gathering_params
      params.require(:gathering).permit(:gathering, :description)
    end
end
