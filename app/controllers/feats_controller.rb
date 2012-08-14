class FeatsController < ApplicationController
  before_filter :signed_in_user
  
  def new
    # Location must be created/chosen before feat creation can continue --- #
    
    if session[:location_id] == nil
      session[:action] = 'create feat'
      redirect_to '/locations'
    else
      @location = Location.find(session[:location_id])
      @feat = Feat.new
    end
  end

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

  def update
  end
end
