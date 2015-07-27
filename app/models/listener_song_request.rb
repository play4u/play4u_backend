class ListenerSongRequest < ActiveRecord::Base
  belongs_to :listener
  belongs_to :song
end