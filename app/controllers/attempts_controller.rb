class AttemptsController < ApplicationController
  before_filter :signed_in_user
  
  def create
    @feat = Feat.find( session[:feat_id])
    @location = @feat.location
                            
    if @feat.timed
      @attempt = Attempt.new( user_id: session[:user_id], 
                              feat_id: session[:feat_id],
                              image: params[:attempt][:image] )
      @attempt.hhmmss_to_score( params[:hours], params[:minutes], 
        params[:seconds] )
    else
      @attempt = Attempt.new( user_id: session[:user_id], 
                              feat_id: session[:feat_id],
                              score: params[:attempt][:score],
                              image: params[:attempt][:image] )
    end
    unless @attempt.errors.any?  
      if @attempt.save
        flash[:notice] = "Record created."
        redirect_to attempt_path( @attempt.id )
     end
    else
      render action: "new"
    end
  end
  
  def destroy
    @attempt = Attempt.find( params[:id] )
    @feat = Feat.find( @attempt.feat_id )
    
    # Only the owning user can delete his attempt ---------------------------- #    
    if @attempt.user_id == session[:user_id]
      @attempt.destroy
    end
    redirect_to feat_path( @attempt.feat_id )
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
    if @feat.timed
      params[:hours]   = "00"
      params[:minutes] = "00" 
      params[:seconds] = "00.0"
    end
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
      @attempt.image = params[:attempt][:image]
      if @attempt.feat.timed
        @attempt.hhmmss_to_score( params[:hours], params[:minutes], 
          params[:seconds] )
      else
        if params[:attempt][:score].not_a_positive_float?
          @attempt.errors[:base] << "Invalid 'Score' value."
        else
          @attempt.score = params[:attempt][:score].to_f
        end              
      end
      unless @attempt.errors.any?  
        if @attempt.save
          flash[:notice] = "Record updated."
          redirect_to attempt_path( @attempt.id )
        end
      else
        render action: "edit"
      end
    end
  end
end