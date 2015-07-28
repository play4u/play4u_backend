class Reservation < ActiveRecord::Base
  has_paper_trail
  
  def to_s
    to_json
  end
end