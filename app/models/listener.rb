class Listener < ActiveRecord::Base
  has_paper_trail
  has_one :location, as: :person
  has_many :reservations
  
  def to_s
    to_json
  end
end