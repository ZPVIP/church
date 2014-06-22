class Admin::PermissionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_admin_permission, only: [:show, :edit, :update, :destroy]

  # GET /admin/permissions
  # GET /admin/permissions.json
  def index
    @permissions = Permission.all
  end

  # GET /admin/permissions/1
  def show
    @users=@permission.users
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
    @permission.update(permission_params) ? (redirect_to admin_permissions_path, notice: 'Permission was successfully updated.') : (render 'edit')
  end

  # DELETE /admin/permissions/1
  def destroy
    @permission.destroy ? (redirect_to admin_permissions_path, notice: 'Permission was successfully deleted.') : (redirect_to admin_permissions_path, alert: '还有用户拥有这个权限，不能删除.')
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
