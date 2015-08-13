class ListenerSongRequest < ActiveRecord::Base
  has_paper_trail
  belongs_to :listener
  belongs_to :song
  
  def to_h
    as_json
  end
  
  def to_json
    as_json.merge({listener: listener, song: song}).to_json
  end
  
  def to_s
    to_json
  end
end