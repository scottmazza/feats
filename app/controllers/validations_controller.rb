class ValidationsController < ApplicationController
  before_filter :signed_in_user

  def create
    @feat = Feat.find( session[:feat_id] )
    @attempt = Attempt.find( session[:attempt_id] )
    existing_validation = 
      @attempt.validations.where( user_id: session[:user_id] ).first
    if existing_validation.nil? and
        session[:user_id] != @attempt.user_id
      @validation = Validation.new( attempt_id: session[:attempt_id],  
                                    user_id:    session[:user_id],
                                    comment:    params[:validation][:comment] )
      if @validation.save
        flash[:notice] = "Validation recorded."
        redirect_to validation_path( @validation.id )
      else
        render action: "new"
      end
    else
      flash[:error] = "You have already validated this attempt."
      redirect_to validation_path( @validation.id )
    end
  end
  
  def destroy
    @validation = Validation.find( params[:id] )
    @attempt    = @validation.attempt
    #
    # Only the owning user can delete his validation
    #
    if @validation.user_id == session[:user_id]
      @validation.destroy
    end
    redirect_to attempt_path( @validation.attempt_id )
  end
  
  def index
    @attempt     = Attempt.find( session[:attempt_id])
    @feat        = @attempt.feat
    @validations = @attempt.validations
    @location    = @feat.location    
  end
  
  def new
    @feat        = Feat.find( session[:feat_id] )
    @location    = @feat.location
    @attempt     = Attempt.find( session[:attempt_id] )
    @validations = @attempt.validations
    @validation  = Validation.new( attempt_id: @attempt.id )
  end
  
  def show
    @validation  = Validation.find( params[:id])
    @attempt     = @validation.attempt
    @feat        = @attempt.feat
    @location    = @feat.location
    @validations = @attempt.validations
  end
end
