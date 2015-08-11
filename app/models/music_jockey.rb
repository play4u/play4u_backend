class MusicJockey < ActiveRecord::Base
  has_paper_trail
  has_one :location, as: :person, :dependent => :delete
  has_one :person_detail, as: :person, :dependent => :delete
  has_many :reservations
  
  def to_s
    to_json
  end
end
