class EmailsController < ApplicationController
  expose(:incident)
  expose(:email,  strategy: EmailStrategy)

  def create
    if email.valid?
      incident.interactions.create!(title: email.subject, content: email.body, start_at: Time.zone.now, contact_person: email.contact_person ,contact_detail: email.to).tag('Email', current_user)
      Delayed::Job.enqueue OutgoingMailJob.new(email)
      redirect_to incident, notice: "Email to #{email.to} was sent successfully"
    else
      render :new
    end
  end

  private
  def email_params
    params.require(:email).permit(:from, :to, :cc, :contact_person, :body, :subject )
  end

end
