class InteractionsController < ApplicationController
  expose(:incident)
  expose(:interactions, ancestor: :incident)
  expose(:interaction, attributes: :interaction_params)

  before_action :authenticate_user!

  def index
    self.interactions = incident.interactions.search(search_params)
  end

  def edit
    respond_with(interaction)
  end

  def create
    interaction.tag(params[:tags], current_user) if interaction.save && params[:tags]
    respond_with(interaction)
  end

  def update
    interaction.tag(params[:tags], current_user) if interaction.save && params[:tags]
    respond_with(interaction, location: incident_url(incident))
  end

  def destroy
    interaction.destroy
    respond_with(interaction, location: incident_url(incident))
  end

  private
  def interaction_params
    params.require(:interaction).permit(:title, :content, :occurred, :target_date, :contact_person, :contact_detail, attachments_attributes: [:name,:image,:id, '_destroy'])
  end

  def search_params
    params.require(:q).permit(:s,:title_or_content_cont, :occurred_lteq, :occurred_gteq,:target_date_lteq, :target_date_gteq,:attachments_id_present, tags_name_in: []) if params[:q]
  end

  def interpolation_options
    { resource_name: interaction.title }
  end
end
