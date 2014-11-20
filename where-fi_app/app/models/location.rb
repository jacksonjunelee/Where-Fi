class Location < ActiveRecord::Base
  has_and_belongs_to_many :users
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end

# need to change lat, long to latitude longitude
