class Artist < ActiveRecord::Base
  has_paper_trail
  has_many :songs
  
  def to_h
    as_json
  end
  
  def to_json
    as_json.merge({songs: songs}).to_json
  end
  
  def to_s
    to_json
  end
end