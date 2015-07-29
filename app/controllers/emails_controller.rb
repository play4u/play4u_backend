class EmailsController < ApplicationController
  # Generate an email to request a song
  def generate_song_request
    listener_song_req_id = params[:listener_song_request_id]
    dj_id = params[:dj_id]
    
    @listener_song_request = ListenerSongRequest.find(listener_song_req_id)
    @dj=Dj.find(dj_id)
    
    render layout: 'emails/email_layout'
  end
end
