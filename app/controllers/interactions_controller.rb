class InteractionsController < ApplicationController
  respond_to :js

  before_action :authenticate_user!
  before_action :get_parent_resource, :new_resource, only: [:create]

  def create
    @interaction.tag(params['hidden-tags']) if @interaction.save
    respond_with(@interaction)
  end

  private
  def get_parent_resource
    @incident = Incident.find(params[:incident_id])
  end

  def new_resource
    @interaction = @incident.interactions.build(interaction_params)
  end

  def interaction_params
    params.require(:interaction).permit(:title, :content, :start_at, :target_date, :contact_person, :contact_detail)
  end
end
