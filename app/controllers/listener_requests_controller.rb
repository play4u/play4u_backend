class ListenerRequestsController < ApplicationController
  before_action :request_params
  
  def request_song   
    ::Proxies::SongRequestProxy
    .new(@listener, @song, @search_radius)
    .request!
    
    render plain: 'OK'
  end
  
  # protected
  #
  protected
  def request_params
    @listener=PersonDetail.find_by(email: params[:email]).person
    @artist=Artist.where(name: params[:artist_name]).first_or_create!
    @song=Song.where(name: params[:song_name], artist_id: @artist.id).first_or_create!
    @position=Util::Position.new(params[:latitude].to_f.abs, params[:longitude].to_f.abs)
    @search_radius=params[:search_radius].to_i.abs
    
    location=Location.new
    location.longitude=@position.longitude
    location.latitude=@position.latitude
    @listener.location=location
    @listener.save!
  end
end
