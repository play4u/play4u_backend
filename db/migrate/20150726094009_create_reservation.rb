class CreateReservation < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :request_timestamp, default: Time.now, index: true
      t.timestamps null: false
    end
    
    add_reference :reservations, :event, index: true, foreign_key: true, null: false
    add_reference :reservations, :dj, index: true, foreign_key: true, null: false
    add_reference :reservations, :listener, index: true, foreign_key: true, null: false
    add_reference :reservations, :song, index: true, foreign_key: true, null: false
  end
end
