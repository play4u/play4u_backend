class CreatePersonDetail < ActiveRecord::Migration
  def change
    create_table :person_details do |t|
      t.string :email
    end
    add_index :person_details, :email
    add_reference :person_details, :person, polymorphic: true, index: true, null:false
  end
end
