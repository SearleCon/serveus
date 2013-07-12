require 'spec_helper'

describe TrashController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'restore'" do
    it "returns http success" do
      get 'restore'
      response.should be_success
    end
  end

  describe "GET 'empty'" do
    it "returns http success" do
      get 'empty'
      response.should be_success
    end
  end

end
