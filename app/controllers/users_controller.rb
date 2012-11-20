class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  
  def edit
    @user = User.find(params[:id])
  end
    
  def search
    @user = nil
    if params[ :usertxt ].present?
      usertxt = params[ :usertxt ].downcase
      if usertxt.is_valid_email?
        @user = User.find_by_email( usertxt )
      else
        @user = User.find( :first,  
                  conditions: ["lower( username ) = ?", usertxt ])
      end
      if @user.nil?
        flash.now.notice = "No users matched your search criteria."
      end
    end
  end
  
  def show
    @user = User.find(params[:id])
    @feat_count = Feat.count_by_user_id( params[:id] )
    @attempt_count = Attempt.count_by_user_id( params[:id] )
  end
  
  def update
    if params[:user][:username].blank?
      flash[:error] = "Username cannot be blank."
      redirect_to action: 'edit', id: session[:user_id]
    else
      @user = User.find(session[:user_id])
      if @user.update_attributes(params[:user])
        flash[:info] = "Profile updated successfully."
        redirect_to root_path
      else
        render action: 'edit', id: session[:user_id]
      end
    end
  end
end
