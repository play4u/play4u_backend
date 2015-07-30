class Reservation < ActiveRecord::Base
  has_paper_trail
  belongs_to :listener
  belongs_to :dj
  belongs_to :event
  belongs_to :song
  
  def to_s
    to_json
  end
end