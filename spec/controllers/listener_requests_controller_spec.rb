require 'rails_helper'

RSpec.describe ListenerRequestsController, type: :controller do
  render_views
  
  describe "GET #request_song" do
    it "returns http success" do
      get :request_song
      
    end
  end

end
