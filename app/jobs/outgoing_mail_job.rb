class OutgoingMailJob < Struct.new(:email)
  def perform
    OutgoingMailer.send_mail(email).deliver
  end
end