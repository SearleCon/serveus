class IncidentsController < ApplicationController
  respond_to :html, :js

  expose(:incidents) { current_user.incidents }
  expose(:incident, attributes: :incident_params)

  etag { current_user.id }

  before_action :authenticate_user!

  def index
    fresh_when(incidents, last_modified: incidents.maximum(:updated_at))
  end

  def show
    fresh_when(incident)
  end

  def create
    incident.save
    respond_with(incident)
  end

  def destroy
    incident.destroy
    respond_with(incident)
  end

  private
  def incident_params
    params.require(:incident).permit(:name)
  end

  def interpolation_options
    { resource_name: incident.name }
  end
end
