require 'spec_helper'

describe InteractionsController do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    sign_in @user
    @incident = create(:incident, user: @user)
  end

  describe "Post '#create'" do
    it 'saves the new incident in the database' do
      expect{
       xhr :post, :create, incident_id: @incident, interaction: attributes_for(:interaction), :'hidden-tags' =>  'test'
      }.to change(Interaction, :count).by(1)
    end

    it 'responds with success' do
      xhr :post, :create, incident_id: @incident, interaction: attributes_for(:interaction),  :'hidden-tags' =>  'test'
      expect(response).to be_success
    end
  end

end
