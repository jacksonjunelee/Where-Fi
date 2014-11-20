class CreateChangeLocationsLatitudeLongitude < ActiveRecord::Migration
  def change
    rename_column :locations, :lat, :latitude
    rename_column :locations, :long, :longitude
  end
end
