class Song < ActiveRecord::Base
  has_paper_trail
  belongs_to :artist
  
  def to_h
    as_json
  end
  
  def to_json
    as_json.merge({artist: artist}).to_json
  end
  
  def to_s
    to_json
  end
end