require 'rails_helper'

RSpec.describe ListenerRequestsController, type: :controller do

  describe "GET #request_song" do
    it "returns http success" do
      get :request_song
      expect(response).to have_http_status(:success)
    end
  end

end
