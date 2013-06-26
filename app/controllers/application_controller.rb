require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  layout :has_layout?

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
end
