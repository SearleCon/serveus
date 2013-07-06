class MailPreview < MailView
    def welcome
      user = Struct.new(:email).new("paul@searleconsulting.co.za")
      mail = UserMailer.welcome(user)
    end

    def feedback_notification
      feedback = Struct.new(:subject, :comment, :created_at).new("Test", "This is a test comment", Time.zone.now)
      mail = FeedbackMailer.notify_support(feedback)
    end
end