class Admin::UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all.order('id DESC').paginate(:page => params[:page], :per_page => 50)
  end

  def edit
  end

  def update
    success = false
    if params[:id] == current_user&.id.to_s
      redirect_to admin_users_path, alert: "你不能在这里修改自己的信息，请点击右上角的设置"
    else
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
        success = @user.update_without_password(user_params)
      else
        success = @user.update_attributes(user_params)
      end
      success ? (redirect_to admin_users_path, notice: '用户信息已更新.') : (render :edit)
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: "Successfully deleted User."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation, :email, :blocked, :permission_ids => [])
  end
end

