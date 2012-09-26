class AttemptsController < ApplicationController
  before_filter :signed_in_user
  
  def create
    @feat = Feat.find( session[:feat_id])
    @location = @feat.location
                            
    if @feat.timed
      @attempt = Attempt.new( user_id: session[:user_id], 
                              feat_id: session[:feat_id] )
      if params[:hours].not_a_positive_int?
        @attempt.errors[:base] << "Invalid 'Hours' value."
      end
      if params[:minutes].not_a_positive_int?
          @attempt.errors[:base] << "Invalid 'Minutes' value."
      end
      if params[:seconds].not_a_positive_float?
          @attempt.errors[:base] << "Invalid 'Seconds' value."
      end
    else
      @attempt = Attempt.new( user_id: session[:user_id], 
                              feat_id: session[:feat_id],
                              score: params[:attempt][:score] )
    end
    if @attempt.errors.empty? && @feat.timed
      @attempt.score = params[:hours].to_f * 3600.0 + 
                       params[:minutes].to_f * 60.0 +
                       params[:seconds].to_f
      if @attempt.score.zero?
        @attempt.errors[:base] << "Attempt time must be non-zero."
      end
    end
    unless @attempt.errors.any?  
      if @attempt.save
        flash[:notice] = "Attempt recorded."
        redirect_to feat_path( session[:feat_id] )
      end
    else
      render action: "new"
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
      if params[:hours].not_a_positive_int?
        @attempt.errors[:base] << "Invalid 'Hours' value."
      elsif @attempt.update_attributes( params[:attempt] )
        flash[:notice] = "Attempt recorded."
        redirect_to feat_path( session[:feat_id] )
      end        
    end
  end
end