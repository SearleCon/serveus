class FeedbackMailer < ActionMailer::Base
  default from: 'ServeUS <info@servus.herokuapp.com>'

  def notify_support(feedback)
    @feedback = feedback
    mail(to: ENV['SUPPORT_MAIL'],
         subject: "ServeUS Feedback Notification - #{l Time.zone.today}")
  end
end
