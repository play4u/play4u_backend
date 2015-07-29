class CreateJoinTableListenerSongRequest < ActiveRecord::Migration
  def change
    create_table :listener_song_requests  do |t|
      t.timestamps null: false
    end
    
    add_reference :listener_song_requests, :listener, index: true, foreign_key: true, null: false
    add_reference :listener_song_requests, :song, index: true, foreign_key: true, null: false
  end
end
