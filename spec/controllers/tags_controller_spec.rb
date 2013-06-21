require 'spec_helper'

describe TagsController do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    sign_in @user
    @tag = create(:tag, user: @user)

  end

  describe "GET '#index'" do
    it "populates an array of tags" do
      get :index, format: :json
      expect(assigns(:tags)).to match_array [@tag.name]
    end

    it "renders the index view" do
      get :index, format: :json
      expect(response.body).to have_json_path('tags')
      expect(response.body).to have_json_path('tags/0/tag')
      expect(response.body).to have_json_size(1).at_path('tags/0/tag')
    end
  end


end
