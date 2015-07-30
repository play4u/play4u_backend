class Event < ActiveRecord::Base
  has_paper_trail
  belongs_to :dj
  
  # Cascade-delete all reservations 
  has_many :reservations, :dependent => :delete_all
  
  def to_s
    to_json
  end
end