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
    interaction.save
    interaction.tag(params['hidden-tags'], current_user) if interaction.errors.blank? && params['hidden-tags']
    respond_with(interaction)
  end

  def update
    interaction.save
    interaction.update_tags(params['hidden-tags'], current_user) if interaction.errors.blank? && params['hidden-tags']
    interaction.reload
    respond_with(interaction)
  end

  def destroy
    interaction.destroy
    respond_with(interaction)
  end


  private
  def interaction_params
    params.require(:interaction).permit(:title, :content, :start_at, :target_date, :contact_person, :contact_detail, :attachments_array => [])
  end

  def search_params
    params.require(:q).permit(:s,:title_cont, :content_cont, :start_at_lteq, :start_at_gteq,:target_date_lteq, :target_date_gteq, :tags_name_in => []) if params[:q]
  end
end
