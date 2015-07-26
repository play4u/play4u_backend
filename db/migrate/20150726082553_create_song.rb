class CreateSong < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name, unique:true
      t.references :artist, index: true, foreign_key: true
      t.timestamps null: false
    end
    add_index :songs, :name
  end
end
