class CreateMusicJockeySongRequests < ActiveRecord::Migration
  def change
    create_table :music_jockey_song_requests do |t|
      t.timestamps null: false
      t.references :music_jockey, index: true, foreign_key: true, null: false
      t.references :listener_song_request, index: true, foreign_key: true, null:false
    end
  end
end
