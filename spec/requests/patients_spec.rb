require 'rails_helper'

RSpec.describe "Patients", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/patients/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/patients/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/patients/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/patients/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
