class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all.order('id DESC').paginate(:page => params[:page], :per_page => 50)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully created User."
      redirect_to root_path
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    logger.debug @user
  end

  def update
    @user = User.find(params[:id])

    if params[:password].blank?
      params.delete(:password)
      if params[:password_confirmation].blank?
        params.delete(:password_confirmation)
      end
    end

    if params[:id] == current_user.id.to_s
      flash[:warn] = "你不能在这里修改自己的信息，请点击右上角的设置"
      redirect_to admin_users_path
    else
      if @user.update(user_params)
        flash[:notice] = "Successfully updated User."
        redirect_to admin_users_path
      else
        render :edit
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully deleted User."
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :blocked, :permission_ids => [])
  end
end

