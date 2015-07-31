class CreateDj < ActiveRecord::Migration
  def change
    create_table :djs do |t|
      t.string :stage_name, null:false, unique: true
      t.timestamps null: false
    end
  end
end
