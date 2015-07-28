class Listener < ActiveRecord::Base
  has_paper_trail
  has_one :location, as: :person
  
  def to_s
    to_json
  end
end