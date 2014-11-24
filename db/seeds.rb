hotspots = HTTParty.get("https://nycopendata.socrata.com/api/views/jd4g-ks2z/rows.json?accessType=DOWNLOAD")["data"]

Location.destroy_all

hotspots.each do |hotspot|
	Location.create({
		boro: hotspot[9],
		place_name: hotspot[12],
		ssid: hotspot[21],
		latitude: hotspot[14].to_f,
		longitude: hotspot[15].to_f,
		fav_point: 0
	})

end
