require 'active_support/concern'

module PeopleController
  extend ActiveSupport::Concern
  POSITION_NOT_FOUND_ERROR_MESSAGE='Longitude/latitude are required'
  
  included do
    before_action :request_params
    before_action :fetch_position, :fetch_person
    before_action :update_location, only: [:show, :update, :create]
    
    def render_person
      render json: {@person.person_detail.person_type.to_s.downcase.to_sym => 
        {person: @person, location: @person.location}}
    end
    
    def create
      define_person
      
      person_detail=PersonDetail
      .where(email: @email)
      .first_or_initialize
    
      person_detail.person=@person
      person_detail.save!
      
      render_person
    end
    
    # 
    # protected
    #
    protected
    def request_params
      @id=params[:id].to_i if params[:id].present?
      @longitude=params[:longitude].to_f
      @latitude=params[:latitude].to_f
      @email=params[:email]
      @user_ip=params[:socket_ip]
      @user_port=params[:socket_port].to_i
    end
    
    def fetch_person
      @person=PersonDetail.find_by(person_id: @id).person if @id.present?
    end
    
    def update_person
      @person.email=@email if @person && @email.present?
    end
    
    def update_location
      if @person.nil?
        @logger.error 'Could not update location because person was not found'
      elsif @person.location
        @person
        .location
        .update_attributes(latitude: @position.latitude, 
        longitude: @position.longitude,
        socket_ip: @user_ip,
        socket_port: @user_port
        )
      else
        location=Location.create!(latitude: @position.latitude, 
        longitude: @position.longitude,
        socket_ip: @user_ip,
        socket_port: @user_port
        )
        
        @person.location=location
        @person.save!
      end
    end
    
    def fetch_position
      if @latitude.present? && @longitude.present?
        @position=Util::Position.new(@latitude,@longitude)
      else
        @logger.error("[PeopleController] Position is missing. Longitude: #{@longitude}. Latitude: #{@latitude}")
        render plain: POSITION_NOT_FOUND_ERROR_MESSAGE, :status => :internal_server_error
      end 
    end
  end
end