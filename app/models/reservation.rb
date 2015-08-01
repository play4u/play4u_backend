class Reservation < ActiveRecord::Base
  has_paper_trail
  belongs_to :listener
  belongs_to :music_jockey
  belongs_to :song
  
  def to_s
    to_json
  end
end