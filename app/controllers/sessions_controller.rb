class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to user
    else
      redirect_to login_path
    end

  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path
  end
end
