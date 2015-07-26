class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start, null:false
      t.datetime :end
      t.string :description
      t.integer :place_id, null:false
      t.timestamps null: false
    end
  end
end
