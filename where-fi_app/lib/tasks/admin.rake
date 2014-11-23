namespace :admin do
  desc "Deletes all FS Data and repopulate with DB data"
  task repopulate: :environment do
    @ft = GData::Client::FusionTables.new
    @ft.clientlogin(ENV["GOOGLE_ID"],ENV["GOOGLE_PW"])
    @ft.set_api_key(ENV["GOOGLE_API"])
    @table = @ft.show_tables[0]
    @table.truncate!
    hotspots = Location.all
    hotspots.each do |hotspot|
      data = [{ "OBJECTID" => hotspot.id,
              "Boro" => hotspot.boro,
              "Location" => hotspot.place_name,
              "Latitude" => hotspot.latitude,
              "Longitude" => hotspot.longitude,
              "SSID" => hotspot.ssid}]
      @table.insert data
    end
  end
end
