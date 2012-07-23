class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      render 'signin'
    else
      render 'new'
    end
  end
end
