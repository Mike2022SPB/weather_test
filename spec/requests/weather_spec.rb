require 'rails_helper'

RSpec.describe "Weather", type: :request do
  describe "GET /health" do
    it "returns a successful response" do
      get '/health'
      expect(response).to have_http_status(:ok)
    end
  end
end