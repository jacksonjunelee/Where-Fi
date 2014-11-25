class Location < ActiveRecord::Base
	validates_presence_of :ssid, :place_name
  validate :has_address_or_coordinates
	#need to test address without address or cooridnates
  has_and_belongs_to_many :users
  has_many :comments, dependent: :destroy

  geocoded_by :address, :latitude => :latitude, :longitude => :longitude
	#need to be tested
  reverse_geocoded_by :latitude, :longitude, :address => :address
  #explain geocoder!
  after_validation :geocode, :reverse_geocode
  #explain before destroy.
  before_destroy :delete_fusion_table


  def has_address_or_coordinates
    if address.blank? && (latitude.blank? || longitude.blank?)
      errors.add(:address_of_coords, "Wifi Hotspots need an address or coordinates to validate.")
    end
  end

  def nearby_wifi(dist)
  	data = Location.all
  	nearby_wifi = data.select { |spot| self.distance_to([spot.latitude,spot.longitude]) <= dist }
  	sort_nearby_wifi = nearby_wifi.sort_by { |close| self.distance_to([close.latitude, close.longitude]) }
  end

  def add_to_fusion_table
    table = FusionTableApi.get_fusion_table
    data = self.fusion_table_data
    table.insert data
  end

	def update_fusion_table
		table = FusionTableApi.get_fusion_table
		data = self.fusion_table_data
		row_id = table.select "ROWID", "WHERE OBJECTID=#{self.id.to_s}"
		table.delete "#{row_id[0][:rowid]}".to_i
		table.insert data
	end
	#method for data

  def fusion_table_data
    [{
      "OBJECTID" => self.id,
      "Boro"  => self.boro,
      "Location"  => self.place_name,
      "Latitude"  => self.latitude,
      "Longitude" => self.longitude
      }]
  end


	def delete_fusion_table
		table = FusionTableApi.get_fusion_table
		row_id = table.select "ROWID", "WHERE OBJECTID=#{self.id.to_s}"
		table.delete row_id[0][:rowid].to_i unless row_id[0] == nil
	end

  def new_tweet
    client = TwitterApi.get_client
    client.update("New Wifi Hotspot at #{self.place_name}.")
  end

  def update_tweet
    client = TwitterApi.get_client
    client.update("Wifi Hotspot at #{self.place_name} has been edited.")
  end

  def delete_tweet
    client = TwitterApi.get_client
    client.update("Wifi Hotspot at #{self.place_name} has been deleted. :(")
  end

  def add_fav_point
    self.fav_point == nil ? self.fav_point = 1 : self.fav_point += 1
  end

end
