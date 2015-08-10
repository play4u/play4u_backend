class CreateLocation < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :person, polymorphic: true, index: true
      t.float :latitude, index: true, null: false
      t.float :longitude, index: true, null: false
      t.timestamps null: false
    end
  end
end
