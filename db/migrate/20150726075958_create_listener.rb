class CreateListener < ActiveRecord::Migration
  def change
    create_table :listeners do |t|
      t.string :first_name
      t.timestamps null: false
    end
  end
end
