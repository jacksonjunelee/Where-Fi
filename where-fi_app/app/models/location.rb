class Location < ActiveRecord::Base
	validates_presence_of :ssid, :place_name
  #we need to either validate the presence of a lat and long OR an address.

  has_and_belongs_to_many :users
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode


  def nearby_wifi(dist)
	data = Location.all
	nearby_wifi = data.select { |spot| self.distance_to([spot.latitude,spot.longitude]) <= dist}
	sort_nearby_wifi =nearby_wifi.sort_by { |close| self.distance_to([close.latitude, close.longitude ])}
  end
end
