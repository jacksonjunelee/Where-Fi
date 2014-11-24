class Location < ActiveRecord::Base
	validates_presence_of :ssid, :place_name
  validate :has_address_or_coordinates
	#need to test address without address or cooridnates
  has_and_belongs_to_many :users
  geocoded_by :address, :latitude => :latitude, :longitude => :longitude
	#need to be tested
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode


  def has_address_or_coordinates
    if :address.blank? && (:latitude.blank? && :longitude.blank?)
      false
    else
      true
    end
  end

  def nearby_wifi(dist)
  	data = Location.all
  	nearby_wifi = data.select { |spot| self.distance_to([spot.latitude,spot.longitude]) <= dist}
  	sort_nearby_wifi = nearby_wifi.sort_by { |close| self.distance_to([close.latitude, close.longitude])}
  end

  def add_to_fusion_table
    table = ApplicationController.fusiontable
    data = [{
			"OBJECTID" => self.id,
      "Boro"  => self.boro,
      "Location"  => self.place_name,
      "Latitude"  => self.latitude,
      "Longitude" => self.longitude
      }]
    table.insert data
  end

	def update_fusion_table
		table = ApplicationController.fusiontable
		data = [{
			"OBJECTID" => self.id,
			"Boro"  => self.boro,
			"Location"  => self.place_name,
			"Latitude"  => self.latitude,
			"Longitude" => self.longitude
			}]
		row_id = table.select "ROWID", "WHERE OBJECTID=#{self.id.to_s}"
		table.delete "#{row_id[0][:rowid]}".to_i
		table.insert data
	end

	def delete_fusion_table
		table = ApplicationController.fusiontable
		row_id = table.select "ROWID", "WHERE OBJECTID=#{self.id.to_s}"
		table.delete row_id[0][:rowid].to_i
	end

end
