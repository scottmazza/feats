class SessionsController < ApplicationController
  def new
  end
  
  def create
    # 
    # Facebook redirects here after successful login. We'll first ensure that
    # there is a corresponding User record in our DB.
    #    
    auth = request.env["omniauth.auth"]
    user = User.where( email: auth.info.email ).first_or_create!
    # --------------------------------------------------------------------- #
    # The user is in our DB. We'll record the FB auth info in our DB,       #
    # create a session, and redirect the user to our root page.             #
    # --------------------------------------------------------------------- #
    
    user.update_attributes!(
      oauth_provider:   auth.provider,
      oauth_token:      auth[:credentials][:token],
      oauth_expires_at: Time.at(auth.credentials.expires_at),   
      name:             auth.info.name,
      image:            auth.info.image )
 
    session[:user_id] = user.id
    if user.profile_complete?
      redirect_to root_url
    else
      redirect_to controller: 'users', action: 'edit', id: user.id
    end
  end
  
  def destroy
    reset_session
    redirect_to '/signin', info: "Signed out!"
  end
end
