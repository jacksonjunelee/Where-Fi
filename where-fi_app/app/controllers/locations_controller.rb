class LocationsController < ApplicationController

  def index
    coordinates = Geocoder.coordinates(params[:location])
    @location = Location.new({latitude: coordinates[0], longitude: coordinates[1]})
    @c = @location.nearby_wifi(params[:distance].to_f)
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    coordinates = Geocoder.coordinates(location_params[:address])
    @location.latitude = coordinates[0]
    @location.longitude = coordinates[1]
# need latitude and longitude
    if @location.save
      table = ApplicationController.fusiontable
      data = [{ "Boro"  => location_params[:boro],
                "Location"  => location_params[:place_name],
                "Latitude"  => location_params[:latitude],
                "Longitude" => location_params[:longitude]}]
  # need to fix table
         table.insert data
    	redirect_to location_path(@location)
    else
    	render :new
    end
  end

  private
  def location_params
  	params.require(:location).permit(:boro, :place_name, :details, :ssid, :latitude, :longitude, :address)
  end
end
  
