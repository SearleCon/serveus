class MailPreview < MailView
    def welcome
      user = Struct.new(:email).new("paul@searleconsulting.co.za")
      mail = UserMailer.welcome(user)
    end

    def send_mail
      email = Email.new(from: 'test@example.com', to: 'testto@example.com', subject: 'Test', body: 'This is a test', cc: 'test@example.com')
      mail = OutgoingMailer.send_mail(email)
    end

    def feedback_notification
      feedback = Struct.new(:subject, :comment, :created_at).new("Test", "This is a test comment", Time.zone.now)
      mail = FeedbackMailer.notify_support(feedback)
    end
end