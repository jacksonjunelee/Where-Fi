class LocationsController < ApplicationController

  before_action :authenticate, except: [:index, :show]
  
  def index
    coordinates = Geocoder.coordinates(params[:location])
    @location = Location.new({latitude: coordinates[0], longitude: coordinates[1]})
    @radius = params[:distance][:miles].to_f
    @near_wifi = @location.nearby_wifi(@radius)
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
      @location.add_to_fusion_table
    	redirect_to location_path(@location)
    else
    	render :new
    end
  end
  #edit, update, destroy route

  def edit
  end

  def update
  end
  
  private
  def location_params
  	params.require(:location).permit(:boro, :place_name, :details, :ssid, :address)
  end
end
