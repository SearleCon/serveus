class EmailsController < ApplicationController
  expose(:incident)
  expose(:email,  strategy: EmailStrategy)

  def create
    if email.valid?
      Delayed::Job.enqueue OutgoingMailJob.new(email)
      interaction = incident.interactions.create!(title: email.subject, content: email.body, start_at: Time.zone.now, contact_detail: email.to) and interaction.tag('Email Sent', current_user)
      redirect_to edit_incident_interaction_url(incident, interaction), notice: "Email to #{email.to} was sent successfully."
    else
      render :new
    end
  end

  private
  def email_params
    params.require(:email).permit(:from, :to, :cc, :contact_person, :body, :subject )
  end

end
