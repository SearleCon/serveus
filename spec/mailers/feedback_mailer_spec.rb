require "spec_helper"

describe FeedbackMailer do

  let(:feedback){ create(:feedback) }
  let(:email){ FeedbackMailer.notify_support(feedback) }

  it "should be set to be delivered to the support email" do
    email.should deliver_to('support@searleconsulting.co.za')
  end

  it "should contain the subject of the feedback" do
    email.should have_body_text(feedback.subject)
  end

  it "should contain the the feedback comment" do
    email.should have_body_text(feedback.comment)
  end


end
