class Event < ActiveRecord::Base
  has_paper_trail
  belongs_to :dj
  
  def to_s
    to_json
  end
end