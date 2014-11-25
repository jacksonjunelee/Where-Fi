class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to user
    else
      flash[:login_error] = "Password does not match log-in."
      #renamed :login_error for clarity.  
      redirect_to login_path
    end

  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path
  end

end