class TrashCanStrategy < DecentExposure::Strategy
  delegate :current_user, to: :controller


  def resource
    instance = params[:item_ids] ? current_user.incidents.trashed.find(params[:item_ids]) : current_user.incidents.trashed
  end
end