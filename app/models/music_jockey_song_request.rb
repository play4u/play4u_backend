class MusicJockeySongRequest < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :music_jockey
  belongs_to :listener_song_request
  
  def to_h
    as_json
  end
  
  def to_json
    as_json.merge({music_jockey: music_jockey, listener_song_request: listener_song_request}).to_json
  end
  
  def to_s
    to_json
  end
end