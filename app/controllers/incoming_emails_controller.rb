class IncomingEmailsController < ApplicationController
  skip_before_action  :verify_authenticity_token
  skip_before_filter :verify_authenticity_token

  def create
    if EmailReceiver.receive(request)
      render json: {status: 'ok'}
    else
      render json: {status: 'rejected'}, status: 403
    end
  end
end
