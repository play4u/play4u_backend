class ReservationsController < ApplicationController
  before_action :controller_params
  RESERVATION_NOT_FOUND_ERROR_MESSAGE='Reservation not found'
  MJ_NOT_FOUND_ERROR_MESSAGE='Music jockey not found'
  
  # Event start/end times are stored in UTC/GMT timezone
  RAILS_TIMEZONE='+00:00'
  
  def index
    if @mj
      @reservations=Reservation
      .where(music_jockey_id: @mj.id)
      .order(:start_time => :desc, :end_time => :desc)
      .limit(AppConfig::ViewSettings.reservations_row_limit)
      .to_a
      
      render json: {reservations: @reservations}
    else
      render plain: MJ_NOT_FOUND_ERROR_MESSAGE, :status => :internal_server_error
    end
  end

  def create
    @reservation=Reservation.create!(start_time: @start_time,
    end_time: @end_time,
    description: @description,
    place_id: @place_id,
    music_jockey_id: @mj.id,
    listener_id: @listener_song_request.listener.id,
    song_id: @listener_song_request.song.id
    )
    
    render json: {reservation: @reservation}
  end

  def show
    render json: {reservation: @reservation}
  end

  def update
    if @reservation
       @reservation.start_time=@start_time if @start_time
       @reservation.end_time=@end_time if @end_time
       @reservation.description=@description if @description
       @reservation.place_id=@place_id if @place_id
       @reservation.save!
       
      render json: {reservation: @reservation}, :status => :ok
    else
      render plain: 'Reservation not found', :status => :internal_server_error
    end
  end

  def destroy
    if @reservation
      @reservation.destroy
       
      render json: {reservation: @reservation}, :status => :ok
    else
      render plain: 'Reservation not found', :status => :internal_server_error
    end
  end
  
  protected
  def controller_params
    begin
      @reservation=Reservation.find(params[:id].to_i.abs)
    rescue ActiveRecord::RecordNotFound => e
      @logger.debug e.message + '\n' + e.backtrace.inspect
    end
    
    @start_time=start_time_param
    @end_time=end_time_param
    
    @description=params[:description]
    @place_id=params[:place_id].to_i.abs
    
    begin
      @mj=MusicJockey.find(params[:music_jockey_id].to_i.abs)
    rescue
      @logger.debug e.message + '\n' + e.backtrace.inspect
    end
    
    begin
      @listener_song_request=ListenerSongRequest
      .find(params[:listener_song_request_id].to_i.abs)
    rescue ActiveRecord::RecordNotFound => e
      @logger.debug e.message + '\n' + e.backtrace.inspect
    end
  end
  
  def start_time_param
    Time
    .new(
    params[:start_year].to_i.abs,
    params[:start_month].to_i.abs,
    params[:start_day].to_i.abs,
    params[:start_hour].to_i.abs,
    params[:start_minute].to_i.abs,
    0,
    RAILS_TIMEZONE
    )
  rescue ArgumentError => e
    @logger.debug e.message + '\n' + e.backtrace.inspect
  end
  
  def end_time_param
    Time
    .new(
    params[:end_year].to_i.abs,
    params[:end_month].to_i.abs,
    params[:end_day].to_i.abs,
    params[:end_hour].to_i.abs,
    params[:end_minute].to_i.abs,
    0,
    RAILS_TIMEZONE
    )
  rescue ArgumentError => e
    @logger.debug e.message + '\n' + e.backtrace.inspect
  end
end