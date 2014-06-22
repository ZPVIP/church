class GroupsController < ApplicationController
  load_and_authorize_resource
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  def index
    @groups = Group.all.order('id')
  end

  # GET /groups/1
  def show
    @contacts=@group.members
    @emails='';
    @contacts.each{|c| @emails += c.name + ' <' + c.email + '>; ' if not c.email.blank?}
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  def create
    @group = Group.new(group_params)
    @group.save ? (redirect_to groups_path, notice: 'Group was successfully created.' ):(render 'new')
  end

  # PATCH/PUT /groups/1
  def update
    @group.update(group_params) ? (redirect_to groups_path, notice: 'Group was successfully updated.') : (render 'edit')
  end

  # DELETE /groups/1
  def destroy
    @group.destroy ? (redirect_to groups_path, notice: 'Group was successfully deleted.') : (redirect_to groups_path, alert: '该小组还有成员，不能删除.')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description)
    end
end
