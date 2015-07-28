class ListenerSongRequest < ActiveRecord::Base
  has_paper_trail
  belongs_to :listener
  belongs_to :song
end