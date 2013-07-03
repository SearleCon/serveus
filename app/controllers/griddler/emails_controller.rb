class Griddler::EmailsController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def create
    normalized_params.each do |p|
      Griddler::Email.new(p).process
    end
    head :ok
  end

  private

  def normalized_params
    Array.wrap(Griddler.configuration.email_service.normalize_params(params))
  end
end