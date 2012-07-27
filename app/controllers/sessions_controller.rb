class SessionsController < ApplicationController
  def new
  end
  
  def create
    # ----------------------------------------------------------------------- #
    # Facebook redirects here after successful login. We'll first make sure   #
    # that the email address they are signed into FB with is in our database. #
    # ----------------------------------------------------------------------- #
    
    auth = request.env["omniauth.auth"]
    user = User.find_by_email(auth.info.email)
    if !user
      flash[:error] = "Please sign up first." 
      redirect_to '/users/new'
    else
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
      if !user.profile_complete?
        redirect_to controller: 'users', action: 'edit', id: user.id
      else
        redirect_to root_url
      end
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to '/signin', info: "Signed out!"
  end
end
