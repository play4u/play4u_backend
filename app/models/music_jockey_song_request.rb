class MusicJockeySongRequest < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :music_jockey
  belongs_to :listener_song_request
  
  def to_s
    to_json
  end
end