class InteractionsController < ApplicationController
  respond_to :js, :html

  layout false


  expose(:incident)
  expose(:interactions, ancestor: :incident)
  expose(:interaction, attributes: :interaction_params)

  before_action :authenticate_user!

  def create
    interaction.tag(params['hidden-tags'], current_user) if interaction.save && params['hidden-tags']
    respond_with(interaction, location: incident_url(incident))
  end


  private
  def interaction_params
    params.require(:interaction).permit(:title, :content, :start_at, :target_date, :contact_person, :contact_detail, :attachments_array => [])
  end
end
