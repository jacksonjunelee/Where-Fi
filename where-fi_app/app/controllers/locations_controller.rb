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
  end

end

#state in private location_params
