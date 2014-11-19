class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :boro
      t.string :place_name
      t.text :details
      t.string :ssid
      t.text :address
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
