class EmailStrategy < DecentExposure::Strategy
  delegate :current_user, to: :controller




  def resource
    instance = params[:email] ?  model.new(controller.send(:email_params)) :  model.new(from: current_user.email )
  end
end