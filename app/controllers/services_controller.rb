class ServicesController < ApplicationController
  load_and_authorize_resource
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  include TheSortableTreeController::Rebuild

  # GET /services
  def index
    @services = Service.nested_set.all
  end

  # GET /services/1
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  def create
    @service = Service.new(service_params)
    @service.save ? (redirect_to services_path, notice: 'Service was successfully created.') : (render 'new')
  end

  # PATCH/PUT /services/1
  def update
    @service.update(service_params) ? (redirect_to services_path, notice: 'Service was successfully updated.') : (render 'edit')
  end

  # DELETE /services/1
  def destroy
    @service.destroy
    redirect_to services_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:title, :parent_id, :lft, :rgt, :depth)
    end
end
