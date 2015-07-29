class Artist < ActiveRecord::Base
  has_paper_trail
  has_many :songs
  
  def to_s
    to_json
  end
end