require 'rails_helper'

RSpec.describe "CommunityPostComments", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/community_post_comments/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/community_post_comments/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
