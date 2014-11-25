class GeocoderApi

	def self.get_coordinates(location)
		coordinates = nil
		unless location == ""
			coordinates = Geocoder.coordinates(location + " New York City")
		end
	end
	#when using bing maps search, many more searches return nil.  To massage this, we tagged an NYC to the string.  If the user enters nothing, coordinates return nil and we get an input error.  
end