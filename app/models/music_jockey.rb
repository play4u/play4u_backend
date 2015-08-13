class MusicJockey < ActiveRecord::Base
  has_paper_trail
  has_one :location, as: :person, :dependent => :delete
  has_one :person_detail, as: :person, :dependent => :delete
  has_many :reservations, :dependent => :delete_all
  
  def to_h
    as_json
  end
  
  def to_json
    as_json.merge({location: location, person_detail: person_detail}).to_json
  end
  
  def to_s
    to_json
  end
end
