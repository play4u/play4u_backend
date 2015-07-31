require 'active_support/concern'

module PeopleController
  extend ActiveSupport::Concern
  
  included do
    before_action :fetch_position, :fetch_person
    after_action :update_location, only: [:show, :update, :create]
    
    def create
      define_person
      
      person_detail=PersonDetail
      .where(email: params[:email])
      .first_or_initialize
    
      person_detail.person=@person
      person_detail.save!
      
      render_person
    end
    
    # 
    # protected
    #
    protected
    def fetch_person
      @person=PersonDetail.find_by(person_id: params[:id].to_i).person if params[:id]
    end
    
    def update_location
      if @person.nil?
        @logger.error 'Could not update location because person was not found'
      elsif @person.location
        @person
        .location
        .update_attributes(latitude: @position.latitude, 
        longitude: @position.longitude)
      else
        location=Location.create!(latitude: @position.latitude, longitude: @position.longitude)
        @person.location=location
        @person.save!
      end
    end
    
    def fetch_position
      @position=Util::Position.new(params[:latitude].to_f,params[:longitude].to_f) 
    end
  end
end