require 'active_support/concern'

module PeopleController
  extend ActiveSupport::Concern
  POSITION_NOT_FOUND_ERROR_MESSAGE='Longitude/latitude are required'
  
  included do
    before_action :request_params
    before_action :retrieve_position, :fetch_person
    before_action :update_location, only: [:show, :update]
    
    def create
      create_person
      render_person
    end
    
    # 
    # protected
    #
    protected
    def render_person
      render json: {@person.person_detail.person_type.to_s.downcase.to_sym => 
        {person: @person, person_detail: @person.person_detail, location: @person.location}}
    end
    
    def create_person
      @person=define_person
      
      person_detail=PersonDetail
      .where(email: @email)
      .first_or_initialize
    
      person_detail.person=@person
      person_detail.save!
      
      update_location
    end
    
    def request_params
      @id=params[:id].to_i if params[:id].present?
      @longitude=params[:longitude].to_f
      @latitude=params[:latitude].to_f
      @email=params[:email]
    end
    
    def fetch_person
      @person=PersonDetail.find_by(person_id: @id).person if @id.present?
    end
    
    def update_person
      create_person if @person.nil?
      @person.email=@email if @person && @email.present?
    end
    
    def update_location
      if @person.location.present?
        @person
        .location
        .update_attributes(latitude: @position.latitude, 
        longitude: @position.longitude,
        )
      else
        location=Location.new
        location.latitude=@position.latitude 
        location.longitude=@position.longitude
        @person.location=location
        @person.save!
      end
    end
    
    def retrieve_position
      if @latitude.present? && @longitude.present?
        @position=Util::Position.new(@latitude,@longitude)
        @logger.info("Location: #{@position}")
      else
        @logger.error("[PeopleController] Position is missing. Longitude: #{@longitude}. Latitude: #{@latitude}")
        render plain: POSITION_NOT_FOUND_ERROR_MESSAGE, :status => :internal_server_error
      end 
    end
  end
end
