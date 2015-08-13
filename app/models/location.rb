class Location < ActiveRecord::Base
  has_paper_trail
  belongs_to :person, polymorphic: true
  
  def get_position
    Util::Position.new(latitude, longitude)
  end
  
  def to_h
    as_json
  end
  
  def to_json
    as_json.merge({person: person}).to_json
  end
  
  def to_s
    to_json
  end
end