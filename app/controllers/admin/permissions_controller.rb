class Admin::PermissionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_admin_permission, only: [:show, :edit, :update, :destroy]

  # GET /admin/permissions
  # GET /admin/permissions.json
  def index
    @permissions = Permission.all
  end

  # GET /admin/permissions/new
  def new
    @permission = Permission.new
  end

  # GET /admin/permissions/1/edit
  def edit
  end

  # POST /admin/permissions
  def create
    @permission = Permission.new(permission_params)
    @permission.save ? (redirect_to admin_permissions_path, notice: 'Permission was successfully created.') : (render :new)
  end

  # PATCH/PUT /admin/permissions/1
  def update
    respond_to do |format|
      if @permission.update(permission_params)
        format.html { redirect_to admin_permissions_path, notice: 'Permission was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /admin/permissions/1
  def destroy
    @permission.destroy
    respond_to do |format|
      format.html { redirect_to admin_permissions_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_permission
      @permission = Permission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permission_params
      params.require(:permission).permit(:action, :subject, :description)
    end
end
