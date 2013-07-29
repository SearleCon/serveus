class OutgoingMailer < ActionMailer::Base
  def send_mail(email)
    @body = email.body
    mail(from: email.from, to: email.to, cc: email.cc, bcc: email.from, subject: email.subject, reply_to: email.from)
  end
end
