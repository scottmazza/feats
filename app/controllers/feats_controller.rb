class FeatsController < ApplicationController
  before_filter :signed_in_user
  helper :maps
  
  def create
    @feat = Feat.new( params[:feat] )
    @feat.user = User.find( session[:user_id] )
    @feat.location = @location = Location.find( session[:location_id] )
    @feat.name = @feat.name.lstrip.rstrip
    if @feat.save
      flash[:notice] = "Feat created successfully."
      redirect_to @feat
    else
      render action: 'new'
    end
  end

  def destroy
    @feat = Feat.find( params[:id] )
    #
    # Only the owning user can delete his attempt 
    #  
    if @feat.user_id == session[:user_id]
      @feat.destroy
    end
    redirect_to user_path( @feat.user_id )
  end
  
  def edit
    @feat = Feat.find( params[ :id ])
    @location = @feat.location
    render action: 'new'
  end
  
  def index
    if params[:user_id].present?
      @user = User.find( params[:user_id] )
    else
      @user = current_user
    end
    @feats = Feat.find_all_by_user_id( @user.id )
  end
  
  def new
    # Location must be created/chosen before feat creation can continue ------ #
    
    @feat = Feat.new
    if params[ :location_id ].present?
      @location = Location.find( params[ :location_id] )
      session[:location_id] = @location.id
      @feats = Feat.find_all_by_location_id( @location.id ) 
    elsif session[:location_id].present? 
      @location = Location.find( session[:location_id] )
      @feats = Feat.find_all_by_location_id( @location.id ) 
    else
      redirect_to locate_locations_path
    end
  end

  def search
    @feats = []
    unless params[ :distance ].present?
      user = User.find( session[ :user_id ]) 
      unless user.location.blank?
        params[ :distance ] = '50'
        params[ :address ] = user.location
      end 
    end
    if params[ :distance ].present?
      if params[ :distance ].not_a_positive_float?
        flash.now[ :error ] = "Invalid distance, (#{params[ :distance ]})"
      else
        distance = params[ :distance ].to_f
        if distance < 0 || distance > 50
          flash.now[ :error ] = "Distance must be in the range [0..50]."
        else        
          unless params[ :address ].blank?
            # Attempt to geolocate input address ----------------------------- #        
            @latitude, @longitude = Geocoder.coordinates(params[ :address ])
          end
          if @latitude.nil? && @longitude.nil? 
            flash.now[ :error ] = "Please provide a valid search address."
          else
            # Input is valid. Use standard address & perform search ---------- #
            params[ :address ] = Geocoder.address( [@latitude, @longitude] )
            @locations = Location.near([@latitude, @longitude], distance )
            if @locations.nil?
              flash.now[ :notice ] = "No feats found in that area"
            else
              @locations.each do |l|
                @feats += Feat.find_all_by_location_id(l.id)
              end
              unless @feats.any?
                flash.now[ :notice ] = "No feats found in that area"
              end
            end
          end
        end
      end
    end
  end
  
  def show
    @feat           = Feat.find(params[:id])
    @user           = @feat.user
    @location       = @feat.location
    @attempt_exists = false
    if @feat.low_score_wins 
      @attempts = Attempt.find_all_by_feat_id( @feat.id, order: 'score' )
    else
      @attempts = Attempt.find_all_by_feat_id( @feat.id, order: 'score DESC' )
    end
    session[:feat_id] = @feat.id
  end
  
  def update
    @feat = Feat.find( params[ :id ])
    #
    # Only the owning user can update his feat
    #
    if @feat.user_id == session[ :user_id ]
      @feat.name = params[ :feat ][ :name ]
      @feat.description = params[ :feat ][ :description ]
      if @feat.save
        flash[ :success ] = "Feat updated."
        redirect_to feat_path( @feat )
      else
        render action: "new"
      end
    end
  end
end
