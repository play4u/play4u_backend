class EventsController < ApplicationController
  before_action :event_params
  before_action :check_form_post_params, only: [:create]
  
  def index
  end

  def new
  end

  def create
    Event.create(params)
    
    Service::Mailgun::EmailSongApprovalProxy
    .new(@dj,@listener_song_request)
    .send!
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  protected
  def event_params
    params.require(:event).permit(:start, :end, :description, :place_id)
  end
  
  def check_form_post_params
    @dj=Dj.find(params[:dj_id].to_i)
    @listener_song_request=Listener.find(params[:listener_song_request_id].to_i)
  end
end
