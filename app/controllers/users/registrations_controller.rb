class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super
    Delayed::Job.enqueue WelcomeMailJob.new(@user.id) unless @user.invalid?
  end

end