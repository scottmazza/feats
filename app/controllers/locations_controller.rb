class LocationsController < ApplicationController
  before_filter :signed_in_user

  def new
    @location = Location.new(
                  address:   session[:address],
                  latitude:  session[:latitude],
                  longitude: session[:longitude])
                  
  end
    
  def create
    @location = Location.new(
                  name: params[:location][:name],
                  address:session[:address],
                  latitude: session[:latitude],
                  longitude: session[:longitude])
                  
    if !@location.valid?
      render action: :new
    else                       
      # Check for a location with the same name (sans whitespace, etc.) --- #
      @locations = Location.find_names_by_lat_long(session[:latitude], 
                      session[:longitude])
      @locations.each do |loc|
        if @location.name.gsub( /[\s\W]+/, "").casecmp( loc.name.gsub(/[\s\W]+/, "")) == 0
          session[:location_id] = loc.id
          flash[:notice] = "Using existing location."
          break
        end
      end
      if session[:location_id].nil?
        @location.user = User.find(session[:user_id])
        @location.save!
        session[:location_id] = @location.id
        flash[:notice] = "Location created."
      end
      redirect_to new_feat_path
    end
  end
  
  def choose_from_existing
    # Use address obtained from Geocoder ---------------------------------- #            
    @location = Location.new(
                  address:   session[:address],
                  latitude:  session[:latitude],
                  longitude: session[:longitude])
                  

    @locations = Location.find_names_by_lat_long(session[:latitude], 
                    session[:longitude])
                    
    if @locations.empty?
      redirect_to action: :new
    end
    # --------------------------------------------------------------------- #
    # Location(s) exist with same lat and longitude. User must choose one   #
    # or create a new one.                                                  #
    # --------------------------------------------------------------------- #
  end
  
  def locate
    if params[:location].nil?           
      # Empty form -------------------------------------------------------- #
      session[:address]   = nil
      session[:latitude]  = nil
      session[:longitude] = nil
      @location = Location.new
      
    else             
      # Populate location with user entered data and validate ------------- #           
      @location = Location.new( name: params[:location][:address],
                                address: params[:location][:address])
      @location.latitude  = 0
      @location.longitude = 0
      
      if !@location.valid?        
        # Keep rendering with errors until valid -------------------------- #        
        render  
              
      else
        # Attempt to geolocate input address ------------------------------ #        
        @location.latitude, @location.longitude = 
          Geocoder.coordinates(@location.address)
          
        if ( @location.latitude == 0 && @location.longitude == 0 )
          @location.errors.add_to_base("Cannot locate address.")
          render
          
        else
          # We have coordinates, but do they match the input address? ----- #
          session[:address] = Geocoder.address( [@location.latitude,
                                @location.longitude])
          session[:latitude]  = @location.latitude
          session[:longitude] = @location.longitude
          
          if !session[:address].downcase.eql?(@location.address)
            # They don't match. Verify new address with user -------------- #            
            render
          end
        end
      end
    end
  end
  
end
