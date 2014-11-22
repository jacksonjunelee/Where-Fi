class Location < ActiveRecord::Base
	validates_presence_of :ssid, :place_name
  validate :has_address_or_coordinates
  #we need this line to validate either address or lat/long
	#validates_presence_of :address || :latitude, :longitude
  #this code above does not work as we expect.
  #we need to either validate the presence of a lat and long OR an address.
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
  	sort_nearby_wifi = nearby_wifi.sort_by { |close| self.distance_to([close.latitude, close.longitude ])}
  end
end
