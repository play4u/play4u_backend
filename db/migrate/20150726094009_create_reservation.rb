class CreateReservation < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :event, index: true, foreign_key: true, null: false
      t.references :dj, index: true, foreign_key: true, null: false
      t.integer :listener_id, null: false
      t.integer :song_id, null: false
      t.datetime :request_timestamp, null: false
      t.timestamps null: false
    end
  end
end
