class FeatsController < ApplicationController
  before_filter :signed_in_user
  
  def create
    @feat = Feat.new(params[:feat])
    @feat.user = User.find(session[:user_id])
    @feat.location = @location = Location.find(session[:location_id])
    if @feat.save
      redirect_to @feat
    else
      render action: 'new'
    end
  end

  def edit
  end

  def new
    # Location must be created/chosen before feat creation can continue --- #
    
    @feat = Feat.new
    if !params[:location_id].nil?
      @location = Location.find(params[:location_id])
      render
    elsif !session[:location_id].nil? 
      @location = Location.find(session[:location_id])
    else
      redirect_to locate_locations_path
    end
  end

  def show
    @feat     = Feat.find(params[:id])
    @user     = @feat.user
    @location = @feat.location
  end
  
  def update
  end
end
