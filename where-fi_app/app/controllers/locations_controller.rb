class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
  end

end

#state in private location_params
