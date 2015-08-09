class ListenerRequestsController < ApplicationController
  before_action :request_params, only: [:request_song]
  
  def request_song   
    Controllers::Proxy::SongRequestProxy
    .new(@listener, @song, @search_radius)
    .request!
    
    render plain: 'OK'
  end
  
  # protected
  #
  protected
  def request_params
    @listener=Listener.find_by(email: params[:email])
    @artist=Artist.where(name: params[:artist_name]).first_or_create!
    @song=Song.where(name: params[:song_name], artist_id: @artist.id).first_or_create!
    @position = Util::Position.new(params[:latitude].to_f,params[:longitude].to_f)
    @search_radius=params[:search_radius]
  end
end
