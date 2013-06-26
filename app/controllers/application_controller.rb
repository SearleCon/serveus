require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  respond_to :html

  layout :has_layout?

  before_action :set_timezone



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
  def devise_parameter_sanitizer
    User::ParameterSanitizer.new(User, :user, params)
  end
end
