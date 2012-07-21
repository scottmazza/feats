class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
  end
end
