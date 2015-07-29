class Song < ActiveRecord::Base
  has_paper_trail
  belongs_to :artist
  
  def to_s
    to_json
  end
end