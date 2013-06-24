class UserMailer < ActionMailer::Base
  default from: 'ServeUS <info@servus.herokuapp.com>'
  #default_url_options[:host] = 'serveus.herokuapp.com'

  def welcome(user)
    @user = user
    @url  = root_url
    mail(to: user.email,
         subject: "Welcome to ServUs")
  end
end
