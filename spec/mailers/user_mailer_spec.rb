require "spec_helper"

describe UserMailer do
  include Rails.application.routes.url_helpers

  let(:user) { create(:user) }
  let(:email){ UserMailer.welcome(user) }


  it "should be set to be delivered to the user email" do
    email.should deliver_to(user.email)
  end

  it "should contain the user's message in the mail body" do
    email.should have_body_text(/Welcome/)
  end

  it "should contain a link to the homepage" do
    email.should have_body_text(/#{root_url}/)
  end

  it "should have the correct subject" do
    email.should have_subject(/Welcome to ServUs/)
  end

end
