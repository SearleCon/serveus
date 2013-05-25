require 'spec_helper'

describe ContactFormController do


  describe "GET 'new'" do

    it "generates a new contact_form" do
      get 'new'
      expect(assigns(:contact_form)).to be_a_new(ContactForm)
    end

    it "renders the new template" do
      get 'new'
      expect(response).to render_template :new
    end
  end

  describe "GET 'create'" do

  end

end
