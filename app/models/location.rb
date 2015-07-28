class Location < ActiveRecord::Base
  belongs_to :person, polymorphic: true
  
  def get_position
    Util::Position.new(latitude, longitude)
  end
  
  def to_s
    to_json
  end
end