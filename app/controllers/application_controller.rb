require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  layout :has_layout?

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_timezone


  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def has_layout?
    false if request.xhr?
  end

  def set_timezone
    Time.zone = current_user.time_zone if  current_user && current_user.time_zone?
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:time_zone, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:time_zone, :email, :password, :password_confirmation, :current_password) }
  end
end
