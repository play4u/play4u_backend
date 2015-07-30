class ListenerRequestsController < ApplicationController
  before_action :strong_params
  before_action :check_params, only: [:request_song]
  
  def request_song   
    Controllers::Proxy::SongRequestProxy
    .new(@listener, @song, @position)
    .request!
  end
  
  # protected
  #
  protected
  def strong_params
    params.require(:artist).permit(:name)
    params.require(:song).permit(:name)
  end
  
  def check_params
    @listener=Listener.find_by(email: params[:email])
    
    @song=Song
    .joins(:artist)
    .where('Songs.name=?', params[:song_name])
    .where('Artists.name=?', params[:artist_name])
    .first
    
    # If the song was not found and the arist is not in the DB then
    # create an Artist
    if @song.blank? && Artist.find_by(name: params[:artist_name]).blank?
      @artist=Artist.create(name: params[:artist_name]) 
    end
    
    # If the song is not in the DB then create the Song
    @song=Song.create(artist_id: @artist.id, name: params[:song_name]) if @song.blank?
  
    @position = Util::Position.new(params[:latitude].to_f,params[:longitude].to_f)
  end
end
