class IncidentsController < ApplicationController
  respond_to :html

  expose(:incidents) { current_user.incidents }
  expose(:incident, attributes: :incident_params)

  before_action :authenticate_user!



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
