class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
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
  
  def update
    if params[:user][:username].blank?
      flash[:error] = "Username cannot be blank."
      redirect_to action: 'edit', id: params[:id]
    else
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        flash[:info] = "Profile updated successfully."
      end
      redirect_to action: 'edit', id: params[:id]
    end
  end
end
