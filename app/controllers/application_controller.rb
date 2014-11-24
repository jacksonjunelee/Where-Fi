class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def home
    render :home
  end

  def self.fusiontable
    @ft = GData::Client::FusionTables.new
    @ft.clientlogin(ENV["GOOGLE_ID"],ENV["GOOGLE_PW"])
    @ft.set_api_key(ENV["GOOGLE_API"])
    @login = @ft.show_tables[0]
  end

  #this one is called on the locations model.  

  def self.twitter
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  #this is called

  def authenticate
    redirect_to login_path unless current_user
  end

  def current_user
    User.find(session[:current_user_id]) if session[:current_user_id]
  end

end
