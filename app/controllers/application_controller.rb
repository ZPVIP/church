class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :detect_device_type

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "你没有权限! 请联系管理员。"
    redirect_to request.env['HTTP_REFERER'] || root_path
  end

  # logger.debug "debug|info|warn|error|fatal"

  def my_ip
    require 'socket'
    ip=Socket.ip_address_list.detect { |intf| intf.ipv4_private? }
    ip.ip_address if ip
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username,:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :name,:email, :password, :password_confirmation, :current_password) }

  end


  private
  def detect_device_type
    case request.user_agent
      when /ip(hone|od)/i
        request.variant = :phone
      when /android.+mobile/i
        request.variant = :phone
      when /Windows Phone/i
        request.variant = :phone
      when /ipad/i
        request.variant = :pad
      when /android|silk/i
        request.variant = :pad
    end
  end
end
