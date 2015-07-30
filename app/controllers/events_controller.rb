class EventsController < ApplicationController
  before_action :strong_params
  before_action :check_form_post_params, only: [:create]
  
  # Event start/end times are stored in UTC/GMT timezone
  RAILS_TIMEZONE='+00:00'
  
  def index
    if @dj
      @events=Event
      .where('dj_id=?',@dj.id)
      .order(:start_time => :desc, :end_time => :desc)
      .limit(AppConfig::ViewSettings.events_row_limit)
      .to_a
      
      render json: @events
    else
      render json: []
    end
  end

  def new
    render nothing: true
  end

  def create
    @event=Event.create(start_time: @start_time,
    end_time: @end_time,
    description: @description,
    place_id: @place_id)
    
    Service::Mailgun::EmailSongApprovalProxy
    .new(@dj,@listener_song_request)
    .send!
    
    render :status => :ok
  end

  def show
    render json: @event
  end

  def edit
    render nothing: true
  end

  def update
   @event.start_time=@start_time if @start_time
   @event.end_time=@end_time if @end_time
   @event.description=@description if @description
   @event.place_id=@place_id if @place_id
   @event.save!
   
   render :status => :ok
  end

  def destroy
    @event.destroy
    render :status => :ok
  end
  
  protected
  def strong_params
    params.require(:event).permit(:id, :start_time, :end_time, 
    :description, :place_id)
  end
  
  def check_form_post_params
    @event=Event.find(params[:id].to_i)
    @start_time=start_time_param
    @end_time=end_time_param
    @description=params[:description]
    @place_id=params[:place_id].to_i
    @dj=Dj.find(params[:dj_id].to_i)
    @listener_song_request=Listener.find(params[:listener_song_request_id].to_i)
  end
  
  def start_time_param
    Time
    .new(
    params[:start_year],
    params[:start_month],
    params[:start_day],
    params[:start_hour],
    params[:start_minute],
    0,
    RAILS_TIMEZONE
    )
  end
  
  def end_time_param
    Time
    .new(
    params[:end_year],
    params[:end_month],
    params[:end_day],
    params[:end_hour],
    params[:end_minute],
    0,
    RAILS_TIMEZONE
    )
  end
end
