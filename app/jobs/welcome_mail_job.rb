class WelcomeMailJob < Struct.new(:user_id)
  def perform
    user = User.find(user_id)
    UserMailer.deliver_welcome(user)
  end
end