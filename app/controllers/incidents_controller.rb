class IncidentsController < ApplicationController
  respond_to :html

  before_action :authenticate_user!
  before_action :get_resource, only: [:show, :destroy]

  def index
    @incidents = current_user.incidents
  end

  def show
    respond_with(@incident)
  end

  def create
    @incident = current_user.incidents.create(incident_params)
    respond_with(@incident)
  end

  def destroy
    @incident.destroy
    respond_with(@incident)
  end

  private
  def get_resource
    @incident = Incident.find(params[:id])
  end



  def incident_params
    params.require(:incident).permit(:name)
  end

  def interpolation_options
    { resource_name: @incident.name }
  end
end
