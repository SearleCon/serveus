class IncidentsController < ApplicationController
  respond_to :html, :js, :json

  expose(:incidents) { current_user.incidents.order(created_at: :desc) }
  expose(:incident, attributes: :incident_params)

  etag { current_user.id }

  before_action :authenticate_user!
  after_action :discard_flash, only: :create

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

  def update
    incident.save
    respond_with(incident)
  end

  def destroy
    incident.destroy
    respond_with(incident, location: incidents_url)
  end


  def close
    incident.update(open: false)
    respond_with(incident, location: incidents_url)
  end

  def close_all
    incidents.open.update_all(open: false)
    respond_with(incidents, location: incidents_url)
  end

  def reopen
    incident.update(open: true)
    respond_with(incident, location: incidents_url)
  end

  def reopen_all
    incidents.closed.update_all(open: true)
    respond_with(incidents, location: incidents_url)
  end

  private
  def incident_params
    params.require(:incident).permit(:name) if params[:incident]
  end

  def interpolation_options
    { resource_name: incident.name }
  end

  def discard_flash
    flash.discard
  end
end
