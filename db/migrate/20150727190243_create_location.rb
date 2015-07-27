class CreateLocation < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :person, polymorphic: true, index: true
      t.integer :latitude
      t.integer :longitude
      t.string :user_ip
    end
  end
end
