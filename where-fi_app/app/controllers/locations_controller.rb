class LocationsController < ApplicationController

  def index
    coordinates = Geocoder.coordinates(params[:location])
    @location = Location.new({lat: coordinates[0], long: coordinates[1]})
    @c = @location.nearby_wifi(params[:distance].to_f)
  end

  def show

  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
    	redirect_to location_path(@location)
    else
    	render :new
    end
  end

  private
  def location_params 
  	params.require(:location).permit(:boro, :place_name, :details, :ssid, :lat, :long, :address)
  end
end

