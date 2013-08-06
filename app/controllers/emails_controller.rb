class EmailsController < ApplicationController
  expose(:incident)
  expose(:email,  strategy: EmailStrategy)

  def create
    if email.valid?
      Delayed::Job.enqueue OutgoingMailJob.new(email)
      interaction = incident.interactions.create!(title: email.subject, content: email.body, contact_detail: email.to) and interaction.tag('Email Sent', current_user)
      redirect_to edit_incident_interaction_url(incident, interaction)
    else
      render :new
    end
  end

  private
  def email_params
    params.require(:email).permit(:from, :to, :cc, :body, :subject )
  end

  def interpolation_options
    { resource_name: email.to }
  end

end
