class ValidationsController < ApplicationController
  before_filter :signed_in_user

  def create
    @feat = Feat.find( session[ :feat_id ] )
    @attempt = Attempt.find( session[ :attempt_id ])
    existing_validation = 
      @attempt.validations.where( user_id: session[:user_id] ).first
    if existing_validation.nil? and
        session[:user_id] != @attempt.user_id
      @validation = Validation.new( attempt_id: session[ :attempt_id ],  
                                    user_id:    session[ :user_id ],
                                    rebuttal:   params[ :validation ][ :rebuttal ],
                                    comment:    params[ :validation ][ :comment ])
      if @validation.save
        if @validation.rebuttal
          flash[:notice] = "Rebuttal recorded."
        else
          flash[:notice] = "Validation recorded."
        end
        redirect_to validation_path( @validation.id )
      else
        render action: "new"
      end
    else
      if existing_validation.rebuttal
        flash[:error] = "You have already rebutted this attempt."
      else
        flash[:error] = "You have already validated this attempt."
      end
      redirect_to validation_path( existing_validation )
    end
  end
  
  def destroy
    @validation = Validation.find( params[ :id ])
    @attempt    = @validation.attempt
    #
    # Only the owning user can delete his validation
    #
    if @validation.user_id == session[ :user_id ]
      @validation.destroy
    end
    redirect_to attempt_path( @validation.attempt_id )
  end
  
  def index
    @attempt     = Attempt.find( session[ :attempt_id ])
    @feat        = @attempt.feat
    @validations = @attempt.validations.where( rebuttal:false )
    @rebuttals   = @attempt.validations.where( rebuttal: true )
    @location    = @feat.location    
  end
  
  def new
    @feat        = Feat.find( session[ :feat_id ])
    @location    = @feat.location
    @attempt     = Attempt.find( session[ :attempt_id ])
    @validations = @attempt.validations
    @validation  = Validation.new( attempt_id: @attempt.id )
  end
  
  def show
    @validation  = Validation.find( params[ :id ])
    @attempt     = @validation.attempt
    @feat        = @attempt.feat
    @location    = @feat.location
    @validations = @attempt.validations.where( rebuttal:false )
    @rebuttals   = @attempt.validations.where( rebuttal: true )
  end
end
