class CreateReservation < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.timestamps null: false
      t.datetime :start_time, null:false
      t.datetime :end_time
      t.string :description
      t.integer :place_id, null:false
    end
    
    add_reference :reservations, :music_jockey, index: true, foreign_key: true, null: false
    add_reference :reservations, :listener, index: true, foreign_key: true, null: false
    add_reference :reservations, :song, index: true, foreign_key: true, null: false
  end
end
