class Users::InvitationsController < Devise::InvitationsController
  def update
      super
      Delayed::Job.enqueue WelcomeMailJob.new(resource.id) unless resource.errors.any?
  end
end