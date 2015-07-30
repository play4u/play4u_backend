class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start, null:false
      t.datetime :end
      t.string :description
      t.integer :place_id, null:false
      t.timestamps null: false
    end
    
    add_reference :events, :dj, foreign_key: true, index: true, null: false
  end
end
