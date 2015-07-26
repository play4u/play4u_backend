class CreateJoinTableListenerSongRequest < ActiveRecord::Migration
  def change
    create_join_table :listeners, :songs, table_name: :listener_song_requests  do |t|
      t.index :listener_id
      t.index :song_id
      t.timestamps null: false
    end
    
    add_foreign_key :listener_song_requests, :listeners
    add_foreign_key :listener_song_requests, :songs
  end
end
