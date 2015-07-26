class CreateListener < ActiveRecord::Migration
  def change
    create_table :listeners do |t|
      t.string :first_name
      t.string :email, null:false, unique:true
      t.timestamps null: false
    end
    add_index :listeners, :email
  end
end
