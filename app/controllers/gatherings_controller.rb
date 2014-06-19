class GatheringsController < ApplicationController
  load_and_authorize_resource
  before_action :set_gathering, only: [:show, :edit, :update, :destroy]

  # GET /gatherings
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
  def create
    @gathering = Gathering.new(gathering_params)
    @gathering.save ? (redirect_to gatherings_path, notice: '聚会信息已被保存.'):(render 'new')
  end

  # PATCH/PUT /gatherings/1
  def update
    @gathering.update(gathering_params)? (redirect_to gatherings_path, notice: '聚会信息顺利更新。') : (render 'edit')
  end

  # DELETE /gatherings/1
  def destroy
    @gathering.destroy
    redirect_to gatherings_url
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
