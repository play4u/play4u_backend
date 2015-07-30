class ReservationsController < ApplicationController
  before_action :controller_params
  
  # Event start/end times are stored in UTC/GMT timezone
  RAILS_TIMEZONE='+00:00'
  
  def index
    if @dj
      @reservations=Reservation
      .where('dj_id=?',@dj.id)
      .order(:start_time => :desc, :end_time => :desc)
      .limit(AppConfig::ViewSettings.reservations_row_limit)
      .to_a
      
      render json: @reservations
    else
      render json: []
    end
  end

  def new
    render nothing: true
  end

  def create
    @reservation=Reservation.create(start_time: @start_time,
    end_time: @end_time,
    description: @description,
    place_id: @place_id)
    
    Service::Mailgun::EmailSongApprovalProxy
    .new(@dj,@listener_song_request)
    .send!
    
    render plain: 'OK', :status => :ok
  end

  def show
    render json: @reservation
  end

  def edit
    render nothing: true
  end

  def update
    if @reservation
       @reservation.start_time=@start_time if @start_time
       @reservation.end_time=@end_time if @end_time
       @reservation.description=@description if @description
       @reservation.place_id=@place_id if @place_id
       @reservation.save!
      render plain: 'OK', :status => :ok
    else
      render plain: 'ERROR', :status => :internal_server_error
    end
  end

  def destroy
    if @reservation
      @reservation.destroy 
      render plain: 'OK', :status => :ok
    else
      render plain: 'ERROR', :status => :internal_server_error
    end
  end
  
  protected
  def controller_params
    begin
      @reservation=Reservation.find(params[:id].to_i)
    rescue ActiveRecord::RecordNotFound => e
      @logger.debug e.message + '\n' + e.backtrace.inspect
    end
    
    @start_time=start_time_param
    @end_time=end_time_param
    
    @description=params[:description]
    @place_id=params[:place_id].to_i
    
    begin
      @dj=Dj.find(params[:dj_id].to_i)
    rescue
      @logger.debug e.message + '\n' + e.backtrace.inspect
    end
    
    begin
      @listener_song_request=Listener.find(params[:listener_song_request_id].to_i)
    rescue ActiveRecord::RecordNotFound => e
      @logger.debug e.message + '\n' + e.backtrace.inspect
    end
  end
  
  def start_time_param
    Time
    .new(
    params[:start_year].to_i,
    params[:start_month].to_i,
    params[:start_day].to_i,
    params[:start_hour].to_i,
    params[:start_minute].to_i,
    0,
    RAILS_TIMEZONE
    )
  rescue ArgumentError => e
    @logger.debug e.message + '\n' + e.backtrace.inspect
  end
  
  def end_time_param
    Time
    .new(
    params[:end_year].to_i,
    params[:end_month].to_i,
    params[:end_day].to_i,
    params[:end_hour].to_i,
    params[:end_minute].to_i,
    0,
    RAILS_TIMEZONE
    )
  rescue ArgumentError => e
    @logger.debug e.message + '\n' + e.backtrace.inspect
  end
end
