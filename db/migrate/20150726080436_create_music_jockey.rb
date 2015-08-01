class CreateMusicJockey < ActiveRecord::Migration
  def change
    create_table :music_jockeys do |t|
      t.string :stage_name, null:false, unique: true
      t.timestamps null: false
    end
  end
end
