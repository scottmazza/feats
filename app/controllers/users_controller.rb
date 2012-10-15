class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:info] = "Signup successful."
      redirect_to '/signin'
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
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
        redirect_to action: 'edit', id: session[:user_id]
      end
    end
  end
end
