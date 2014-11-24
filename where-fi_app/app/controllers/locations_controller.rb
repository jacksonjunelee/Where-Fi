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
    if @location.save
      @location.add_to_fusion_table
    	redirect_to location_path(@location)
    else
    	render :new
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      @location.update_fusion_table
      client = ApplicationController.twitter
      client.update("I'm tweeting with @gem!")
      binding.pry
      redirect_to location_path(@location)
    else
      redirect_to location_path(@location)
    end
  end

  def destroy
    @location = Location.find(params[:id])
    Location.destroy(params[:id])
    @location.delete_fusion_table
    render :home
  end

  def chart
    @location = Location.find(params[:id])
    @near_wifi = @location.nearby_wifi(0.5)
    #@near_wifi = Location.near(@location,0.5)
    render :chart
      #need to check radius
  end

  def searches
    @location = Location.find(params[:id])
    @things = Geocoder.search("#{searches_params} near #{@location.place_name}")
    render :searches
    #need to issue request
    #dropdown
  end

  private
  def location_params
  	params.require(:location).permit(:boro, :place_name, :details, :ssid, :address)
  end

  def searches_params
    params.require(:location).permit(:searches)
  end

end
