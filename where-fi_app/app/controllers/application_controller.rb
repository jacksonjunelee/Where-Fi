class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    render :home
  end

  def self.fusiontable
    @ft = GData::Client::FusionTables.new
    @ft.clientlogin('wherefi@gmail.com', 'teamsneezy')
    @ft.set_api_key('AIzaSyDtLNhGopiszIUoW-EpPcLjoH2YvVXfSR4')
    @login = @ft.show_tables[0]
  end

  def authenticate
    redirect_to login_path unless session[:current_user_id]
  end

end
