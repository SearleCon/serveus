require 'spec_helper'

describe IncidentsController do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    sign_in @user
  end

  describe "GET '#index'" do
    it "populates an array of incidents" do
      incident = create(:incident, user: @user)
      get :index
      expect(controller.incidents).to match_array [incident]
    end

    it "renders the index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "Get '#show'" do
    it "assigns the requested incident to @incident" do
      incident = create(:incident,  user: @user)
      get :show, id: incident
      expect(controller.incident).to eq incident
    end

    it "renders the show view" do
      incident = create(:incident, user: @user)
      get :show, id: incident
      expect(response).to render_template :show
    end
  end

  describe "Post '#create'" do
    it 'saves the new incident in the database' do
      expect{
        post :create, incident: attributes_for(:incident)
      }.to change(Incident, :count).by(1)
    end

    it 'redirects to the new incident' do
      post :create, incident: attributes_for(:incident)
      expect(response).to redirect_to Incident.last
    end
  end

  describe "DELETE destroy" do
    before :each do
      @incident = create(:incident, user: @user)
    end

    it "deletes the incident" do
      expect{
        delete :destroy, id: @incident
      }.to change(Incident, :count).by(-1)
    end

    it "redirects to incidents index" do
        delete :destroy, id: @incident
        expect(response).to redirect_to incidents_url
    end
  end

end
