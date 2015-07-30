class EmailsController < ApplicationController
  before_action :query_params
  layout 'emails/email_layout'
  
  # Generate an email for an updated reservation
  def generate_update_reservation
  end
  
  # Generate an email for a cancelled reservation
  def generate_cancel_reservation
  end
  
  # Generate an email for an approved song
  def generate_song_approve
  end
  
  # Generate an email to request a song
  def generate_song_request
  end
  
  #
  # protected
  #
  protected
  
  def query_params
    begin
      @listener_song_request=ListenerSongRequest
      .find(params[:listener_song_request_id].to_i)
    rescue ActiveRecord::RecordNotFound => e
      @logger.debug e.message+'\n'+e.backtrace.inspect
    end
    
    begin
      @dj=Dj.find(params[:dj_id].to_i)
    rescue ActiveRecord::RecordNotFound => e
      @logger.debug e.message+'\n'+e.backtrace.inspect
    end
    
    begin
      @reservation=Reservation.find(params[:reservation_id].to_i)
    rescue ActiveRecord::RecordNotFound => e
      @logger.debug e.message+'\n'+e.backtrace.inspect
    end
  end
end
