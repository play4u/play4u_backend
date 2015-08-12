class Reservation < ActiveRecord::Base
  has_paper_trail
  belongs_to :listener
  belongs_to :music_jockey
  belongs_to :song
  
  def to_json
    {listener: listener, music_jockey: music_jockey, artist:song.artist, song: song}.to_json
  end
  
  def to_s
    to_json
  end
end