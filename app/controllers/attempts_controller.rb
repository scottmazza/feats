class AttemptsController < ApplicationController
  before_filter :signed_in_user
  
  def create
    @feat = Feat.find( session[:feat_id])
    @attempt = Attempt.new( user_id: session[:user_id], 
                            feat_id: session[:feat_id],
                            score: params[:attempt][:score] )
    if @attempt.save
      flash[:notice] = "Attempt recorded."
      redirect_to feat_path( session[:feat_id] )
    else
      session[:attempt_id] = @attempt.id
      redirect_to new_attempt_path
    end
  end
  
  def edit
    @attempt = Attempt.find( params[:id] )
    @feat = Feat.find( @attempt.feat_id )
    @location = @feat.location
  end
  
  def index
    @attempts = Attempt.find_all_by_user_id( session[:user_id] )
  end
  
  def new
    @feat = Feat.find( session[:feat_id] )
    @location = @feat.location
    @attempt = Attempt.new
  end  
  
  def show
    @attempt = Attempt.find( params[:id] )
    @feat = Feat.find( @attempt.feat_id )    
    @location = @feat.location
  end
  
  def update
    @attempt = Attempt.find( params[:id] )
    
    # Only the owning user can update his attempt ---------------------------- #    
    if @attempt.user_id == session[:user_id]
      if @attempt.update_attributes( params[:attempt] )
        flash[:notice] = "Attempt recorded."
        redirect_to feat_path( session[:feat_id] )
      else
        render action: "edit"
      end        
    end
  end
end