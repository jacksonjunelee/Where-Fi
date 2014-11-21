class LocationsController < ApplicationController

  before_action :authenticate, except: [:index, :show]
  
  def index
    coordinates = Geocoder.coordinates(params[:location])
    @location = Location.new({latitude: coordinates[0], longitude: coordinates[1]})
    @near_wifi = @location.nearby_wifi(params[:distance].to_f)
  end
  #change to home, change to search_results

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
    #set session
  end

  def create
    @location = Location.new(location_params)
    # coordinates = Geocoder.coordinates(location_params[:address])
    # @location.latitude = coordinates[0]
    # @location.longitude = coordinates[1]
    if @location.save
      table = ApplicationController.fusiontable
      data = [{ "Boro"  => location_params[:boro],
                "Location"  => location_params[:place_name],
                "Latitude"  => location_params[:latitude],
                "Longitude" => location_params[:longitude]}]
      #make method in model (location model)
  # need to fix table, incomplete
         table.insert data
    	redirect_to location_path(@location)
    else
    	render :new
    end
  end
  #edit, update, destory route

  def edit
  end

  def update
  end
  
  private
  def location_params
  	params.require(:location).permit(:boro, :place_name, :details, :ssid, :address)
  end
end
