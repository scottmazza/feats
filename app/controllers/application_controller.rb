class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  
  private
  
  def current_user
    if session[ :user_id ]
      @current_user = User.find( session[ :user_id ] )
      if @current_user
        if @current_user.oauth_expires_at < Time.now
          session.delete( :user_id )
          @current_user = nil
        end
      else
        session.delete( :user_id )
        @current_user = nil
      end
    end
    @current_user
  end
  
  def signed_in_user
    redirect_to signin_url, notice: "Please sign in." unless current_user
  end
end
