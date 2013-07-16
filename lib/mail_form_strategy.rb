class MailFormStrategy < DecentExposure::Strategy

  def resource
    instance = params[:contact_form] ?  model.new(controller.send(:contact_form_params)) :  model.new
  end
end