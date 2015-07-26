class CreateReservation < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :event, index: true, foreign_key: true, null: false
      t.references :dj, index: true, foreign_key: true, null: false
      t.references :listener_song_request, index:true, foreign_key:true, null:false, unique:true
      t.timestamps null: false
    end
  end
end
