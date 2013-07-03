class EmailsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    if EmailReceiver.receive(request)
      render json: {status: :ok}
    else
      render json: {status: :forbidden}
    end
  end
end
