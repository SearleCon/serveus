require "spec_helper"

describe OutgoingMailer do
  let(:outgoing){ build(:email) }
  let(:email){ OutgoingMailer.send_mail(outgoing) }

  it 'should deliver from the from address specified' do
    email.should deliver_from(outgoing.from)
  end

  it 'should bcc the from address specified' do
    email.should bcc_to(outgoing.from)
  end

  it 'should reply_to the from address specified' do
    email.should reply_to(outgoing.from)
  end


  it 'should deliver to the to address specified' do
    email.should deliver_to(outgoing.to)
  end

  it 'should cc to the cc address specified' do
    email.should cc_to(outgoing.cc)
  end

  it "should have the correct subject" do
    email.should have_subject(outgoing.subject)
  end

  it "should have the body specified" do
    email.should have_body_text(outgoing.body)
  end





end
