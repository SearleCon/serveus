class EmailsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if EmailReceiver.receive(request)
      render json: {status: 'ok'}
    else
      render json: {status: 'rejected'}, status: 403
    end
  end
end
