class Location < ActiveRecord::Base
	validates_presence_of :ssid, :place_name
  #we need to either validate the presence of a lat and long OR an address.

  has_and_belongs_to_many :users
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode


  def nearby_wifi(dist)
  # coordinates = Geocoder.coordinates(params[:location])
  # location = Location.new {lat: :coordinates[0], long: :coordinates[1]}
  data = HTTParty.get('https://nycopendata.socrata.com/api/views/jd4g-ks2z/rows.json?accessType=DOWNLOAD')["data"]
  nearby_wifi = data.select { |spot| self.distance_to([spot[14].to_f , spot[15].to_f ]) <= dist }
  sort_nearby_wifi = nearby_wifi.sort_by { |close| self.distance_to([close[14].to_f , close[15].to_f ])}
  end
end