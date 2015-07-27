class CreateDj < ActiveRecord::Migration
  def change
    create_table :djs do |t|
      t.string :alias, null:false, unique: true
      t.string :email, null:false, unique: true
      t.timestamps null: false
    end
    add_index :djs, :email
  end
end