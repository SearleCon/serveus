require 'spec_helper'


describe "ContactForm" do

  before { ActionMailer::Base.deliveries = [] }
  let (:last_email) { ActionMailer::Base.deliveries.last }
  let (:email_address) { Faker::Internet.email }


  it "delivers a valid message" do
    visit new_contact_form_path
    fill_in 'Name', with: Faker::Name.name
    fill_in 'Email', with: email_address
    fill_in 'Message', with: Faker::Lorem.sentence(4)
    click_button 'Send message'
    page.body.should have_content('Thank you for your message')
    last_email.to.should include('support@searleconsulting.co.za')
    last_email.from.should include(email_address)
  end

  it "does not deliver a message with a missing email" do
    visit new_contact_form_path
    fill_in 'Name', with: Faker::Name.name
    fill_in 'Message', with: Faker::Lorem.sentence(4)
    click_button 'Send message'
    page.body.should have_content("Email can't be blank")
    last_email.should be_nil
  end

  it "does not deliver spam" do
    visit new_contact_form_path
    fill_in 'Name', with: Faker::Name.name
    fill_in 'Email', with: email_address
    fill_in 'Message', with: Faker::Lorem.sentence(4)
    fill_in 'Nickname', with: Faker::Lorem.word
    click_button 'Send message'
    last_email.should be_nil
  end
end