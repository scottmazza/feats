class LocationsController < ApplicationController
  before_filter :signed_in_user

  def new
    @location = Location.new(
                  street:session[:street],
                  city: session[:city],
                  state: session[:state],
                  zipcode: session[:zipcode],
                  latitude: session[:latitude],
                  longitude: session[:longitude])
  end
  
  def create
    @location = Location.new(
                  name: params[:location][:name],
                  street:session[:street],
                  city: session[:city],
                  state: session[:state],
                  zipcode: session[:zipcode],
                  latitude: session[:latitude],
                  longitude: session[:longitude])
    @location.user = User.find(session[:user_id])
    if @location.save
      session[:location_id] = @location.id
      redirect_to '/feats/new'
    else
      render action: 'new'
    end
  end
  
  def index
    if params[:location] == nil
      @location = Location.new
    else 
      @location = Location.new(
                    name: params[:location][:street], 
                    street: params[:location][:street],
                    city: params[:location][:city], 
                    state: params[:location][:state], 
                    zipcode: params[:location][:zipcode])
      if !@location.valid?
        render
      else
        @locations = Location.find_all_by_latitude_and_longitude( 
                        @location.latitude, @location.longitude)
        if @locations.empty?
          session[:street]    = @location.street
          session[:city]      = @location.city
          session[:state]     = @location.state
          session[:zipcode]   = @location.zipcode
          session[:latitude]  = @location.latitude
          session[:longitude] = @location.longitude
          redirect_to action: 'new'
        end            
      end
    end
  end
end
