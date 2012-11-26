class LocationsController < ApplicationController
  before_filter :signed_in_user

  def new
    @location = Location.new(
                  address:   session[:address],
                  latitude:  session[:latitude],
                  longitude: session[:longitude])
    @locations = 
      Location.find_all_by_latitude_and_longitude( session[:latitude], 
        session[:longitude] )
    @feats = []
    unless @locations.empty?
      @locations.each do |l|
        @feats += Feat.find_all_by_location_id( l.id )
      end
    end                  
  end
    
  def create
    session.delete( :location_id )
    @location = Location.new(
                  name: params[:location][:name],
                  address:session[:address],
                  latitude: session[:latitude],
                  longitude: session[:longitude])
                  
    if @location.valid?
      #
      # Check for a location with the same name (sans whitespace, etc.) 
      #
      @locations = 
        Location.find_all_by_latitude_and_longitude( session[ :latitude ], 
          session[ :longitude ])
      @locations.each do |loc|
        if @location.name.gsub( /[\s\W]+/, "").casecmp( loc.name.gsub(/[\s\W]+/, "")) == 0
          session[ :location_id ] = loc.id
          flash[ :notice ] = "Using existing location."
          break
        end
      end
      if session[ :location_id ].nil?
        @location.user = User.find( session[ :user_id ])
        @location.save!
        session[ :location_id ] = @location.id
        flash[ :notice ] = "Location created."
      end
      redirect_to new_feat_path
    else                       
      render action: :new
    end
  end
  
  def choose_from_existing
    #
    # Use address obtained from Geocoder
    # 
    @location = Location.new(
                  address:   session[:address],
                  latitude:  session[:latitude],
                  longitude: session[:longitude])
                  

    @locations = Location.find_all_by_latitude_and_longitude(session[:latitude], 
                    session[:longitude])
                    
    if @locations.empty?
      redirect_to action: :new
    else
      @feats = []
      @locations.each do |l|
        @feats += Feat.find_all_by_location_id( l.id )
      end
    end
    # 
    # Location(s) exist with same lat and longitude. User must choose one 
    # or create a new one. 
    # 
  end
  
  def locate
    if params[:location].nil? 
      #          
      # Empty form
      #
      session.delete( :address )
      session.delete( :latitude )
      session.delete( :longitude )
      @location = Location.new
      
    else  
      #           
      # Populate location with user entered data and validate
      #       
      @location = Location.new( name: "location name",
                                address: params[ :location ][ :address ] )
      @location.latitude  = 0
      @location.longitude = 0
      
      if @location.valid?
        #
        # Attempt to geolocate input address 
        #
        @location.latitude, @location.longitude = 
          Geocoder.coordinates(@location.address)
          
        if @location.latitude.nil? && @location.longitude.nil? 
          @location.errors[:base] << "Cannot locate address."
          
        else
          # We have coordinates, but do they match the input address? 
          #
          session[ :address ] = Geocoder.address( [@location.latitude,
                                @location.longitude] )
          session[ :latitude ]  = @location.latitude
          session[ :longitude ] = @location.longitude
        end
      else
        # Keep rendering with errors until valid 
        #
        session.delete( :address )       
      end
    end
  end
  
  def select
    location = Location.find( params[ :id ] )
    unless location.nil?
      session[ :location_id ] = location.id
      redirect_to new_feat_path
    end
  end
  
  def show
    @location = Location.find( params[ :id ] )
    @feats = Feat.find_all_by_location_id( @location.id )
  end  
end
