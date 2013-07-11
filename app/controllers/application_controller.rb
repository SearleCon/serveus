require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :js, :json

  protect_from_forgery with: :exception

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  layout :has_layout?

  before_action :set_timezone

  skip_before_action :verify_authenticity_token, if: :json_request?



  private
  def has_layout?
    false if request.xhr?
  end

  def set_timezone
    Time.zone = current_user.time_zone if current_user && current_user.time_zone?
  end

  def after_invite_path_for(resource)
    edit_user_registration_url
  end

  def after_sign_out_path_for(resource)
    new_feedback_url
  end

  def json_request?
    request.format.json?
  end

  protected
  def devise_parameter_sanitizer
    User::ParameterSanitizer.new(User, :user, params)
  end
end
