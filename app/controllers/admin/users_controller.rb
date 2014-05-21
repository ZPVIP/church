class Admin::UsersController < ApplicationController

  before_filter :login_required, :admin_required

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
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

    if params[:user][:password].blank?
      params[:user].delete(:password)
      if params[:user][:password_confirmation].blank?
        params[:user].delete(:password_confirmation)
      end
    end

    if @user.update(user_params) then
      flash[:notice] = "Successfully updated User."
      redirect_to admin_users_path
    else
      render :edit
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
    params.require(:user).permit(:name, :username, :email)
  end
end

