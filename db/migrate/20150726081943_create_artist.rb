class CreateArtist < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name, unique: true
      t.timestamps null: false
    end
    add_index :artists, :name
  end
end
