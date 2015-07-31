class DjController < ApplicationController
  before_action :fetch_dj, only: [:destroy, :show, :update]
  before_action :fetch_position
  after_action :update_location, only: [:show, :update, :create]
  
  def destroy
    if @dj
      @dj.destroy
      render json: {dj: @dj}
    else
      render plain: 'DJ not found', :status => :internal_server_error
    end
  end
  
  def update
    if @dj
      @dj.first_name=params[:stage_name] if params[:stage_name].present?
      @dj.email=params[:email] if params[:email].present?
      @dj.save!
    else
      render plain: 'DJ not found', :status => :internal_server_error
    end
  end
  
  def create
    @dj=Dj
    .where(stage_name: params[:stage_name], email: params[:email])
    .first_or_create!
    
    render json: {dj: @dj}
  end
  
  def show
    if @dj
      render json: {dj: @dj}
    else
      render plain: 'DJ not found', :status => :internal_server_error
    end
  end
  
  #
  # protected
  #
  protected
  def update_location
    @dj.location.update_attributes(@position.latitude, @position.longitude) if @dj.location
    @dj.location.create!(latitude: @position.latitude, longitude: @position.longitude) if @dj.location.nil?
  end
  
  def fetch_position
    @position=Util::Position.new(params[:latitude],params[:longitude])  
  end
  
  def fetch_dj
    @dj=Dj.find_by(email: params[:email])
  end
end
