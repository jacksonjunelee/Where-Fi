class LocationsController < ApplicationController

  before_action :authenticate, except: [:index, :show]

  def index
    coordinates = GeocoderApi.get_coordinates(params[:location])
    #please see lib folder geocoder_api.
    if coordinates == nil
      flash[:address_error] = "Address not found. Please try another address."
      #changed to address_error for clarity.  
      render :home
    else
      @location = Location.new({latitude: coordinates[0], longitude: coordinates[1]})
      #we need @location to be a Location object in order to use Geocoder methods like distance by.  
      @radius = params[:distance][:miles].to_f
      if params[:sort][:sort_value] == 1
        @near_wifi = @location.nearby_wifi(@radius)
      else
        @near_wifi = @location.nearby_wifi(@radius).sort_by { |location| location.fav_point }
      end
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      @location.add_to_fusion_table
      @location.new_tweet
    	redirect_to @location
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
      @location.update_tweet
    end
    redirect_to @location
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    @location.delete_fusion_table
    #do we want a tweet here?
    #after destryo delete fusion table method,
    # need delte button
    render :home
  end

  def chart
    @location = Location.find(params[:id])
    @near_wifi = @location.nearby_wifi(0.5)
    #@near_wifi = Location.near(@location,0.5)
    render :chart
    #is there still a problem here with radius?
  end

  private

  def location_params
  	params.require(:location).permit(:boro, :place_name, :details, :ssid, :address)
  end

end
