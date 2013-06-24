class MailPreview < MailView
    def welcome
      user = Struct.new(:email).new("paul@searleconsulting.co.za")
      mail = UserMailer.welcome(user)
    end
end