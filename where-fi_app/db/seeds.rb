hotspots = HTTParty.get("https://nycopendata.socrata.com/api/views/jd4g-ks2z/rows.json?accessType=DOWNLOAD")["data"]

Location.destroy_all 

hotspots.each do |one_hotspot|
	Location.create({
		boro: one_hotspot[9],
		place_name: one_hotspot[12],
		ssid: one_hotspot[21],
		latitude: one_hotspot[14].to_f,
		longitude: one_hotspot[15].to_f
	})
end


