class InteractionsController < ApplicationController
  respond_to :js, :html

  expose(:incident)
  expose(:interactions, ancestor: :incident)
  expose(:interaction, attributes: :interaction_params)

  before_action :authenticate_user!

  def edit
    respond_with(interaction)
  end

  def create
    interaction.save
    interaction.tag(params['hidden-tags'], current_user) if interaction.errors.blank? && params['hidden-tags']
    respond_with(interaction, location: incident_url(incident))
  end

  def update
    interaction.save
    interaction.update_tags(params['hidden-tags'], current_user) if interaction.errors.blank? && params['hidden-tags']
    interaction.reload
    respond_with(interaction, location: incident_url(incident))
  end

  def destroy
    interaction.destroy
    respond_with(interaction, location: incident_url(interaction.incident))
  end


  private
  def interaction_params
    params.require(:interaction).permit(:title, :content, :start_at, :target_date, :contact_person, :contact_detail, :attachments_array => [])
  end
end
