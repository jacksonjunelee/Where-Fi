class Location < ActiveRecord::Base
	validates_presence_of :address, :ssid, :place_name

  has_and_belongs_to_many :users
  geocoded_by :address, latitude: :lat, longitude: :long
  after_validation :geocode, if: :address_changed?
end

# need to change lat, long to latitude longitude
