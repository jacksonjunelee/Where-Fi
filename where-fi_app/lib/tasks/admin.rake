namespace :admin do
  desc "Deletes all FS Data and repopulate with DB data"
  task repopulate: :environment do
    @ft = GData::Client::FusionTables.new
    @ft.clientlogin('wherefi@gmail.com', 'teamsneezy')
    @ft.set_api_key('AIzaSyDtLNhGopiszIUoW-EpPcLjoH2YvVXfSR4')
    @table = @ft.show_tables[0]
    @table.truncate!
    hotspots = Location.all
    hotspots.each do |one_hotspot|
      data = [{ "OBJECTID" => one_hotspot.id,
              "Boro" => one_hotspot.boro,
              "Location" => one_hotspot.place_name,
              "Latitude" => one_hotspot.latitude,
              "Longitude" => one_hotspot.longitude,
              "SSID" => one_hotspot.ssid}]
      @table.insert data
    end
  end
end
