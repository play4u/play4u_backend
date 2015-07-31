class ListenerController < ApplicationController
  before_action :fetch_listener, only: [:destroy, :show]
  before_action :fetch_position
  after_action :update_location, only: [:show, :update, :create]
  
  def destroy
    if @listener
      @listener.destroy
      render json: {listener: @listener}
    else
      render plain: 'Listener not found', :status => :internal_server_error
    end
  end
  
  def create
    @listener=Listener
    .where(first_name: params[:first_name], email: params[:email])
    .first_or_create!
    
    render json: {listener: @listener}
  end
  
  def update
    if @listener
      @listener.first_name=params[:first_name] if params[:first_name].present?
      @listener.email=params[:email] if params[:email].present?
      @listener.save!
    else
      render plain: 'Listener not found', :status => :internal_server_error
    end
  end
  
  def show
    if @listener
      render json: {listener: @listener}
    else
      render plain: 'Listener not found', :status => :internal_server_error
    end
  end
  
  #
  # protected
  #
  protected
  def update_location
    if @listener.location
      @listener.location.update_attributes(@position.latitude, @position.longitude)
    else 
      @listener.location.create!(latitude: @position.latitude, longitude: @position.longitude) 
    end
  end
  
  def fetch_position
    @position=Util::Position.new(params[:latitude],params[:longitude])  
  end
  
  def fetch_listener
    @listener=Listener.find_by(email: params[:email])
  end
end
