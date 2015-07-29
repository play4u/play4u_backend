class CreateDjSongRequests < ActiveRecord::Migration
  def change
    create_table :dj_song_requests do |t|
      t.timestamps null: false
      t.references :dj, index: true, foreign_key: true, null: false
      t.references :listener_song_request, index: true, foreign_key: true, null:false
    end
  end
end
