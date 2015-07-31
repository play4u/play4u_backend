class CreateLocation < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :person, polymorphic: true, index: true
      t.float :latitude
      t.float :longitude
      t.string :user_ip
      t.timestamps null: false
    end
  end
end
