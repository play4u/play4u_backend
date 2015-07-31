class ListenerRequestsController < ApplicationController
  before_action :controller_params, only: [:request_song]
  
  def request_song   
    Controllers::Proxy::SongRequestProxy
    .new(@listener, @song, @position)
    .request!
    
    render plain: 'OK'
  end
  
  # protected
  #
  protected
  def controller_params
    @listener=Listener.find_by(email: params[:email])
    @artist=Artist.where(name: params[:artist_name]).first_or_create!
    @song=Song.where(name: params[:song_name], artist_id: @artist.id).first_or_create!
    @position = Util::Position.new(params[:latitude].to_f,params[:longitude].to_f)
  end
end
