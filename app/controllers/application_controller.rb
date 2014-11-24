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

  def self.twitter
      Twitter::REST::Client.new do |config|
      config.consumer_key        = "kqMPtcO168DpLDitFCcT7lKoE"
      config.consumer_secret     = "DqAbEyfxacCL9fEWJGbTGv0Ed2jrJsjir4oFQQq940Pb9OEZxP"
      config.access_token        = "2890858053-8NsYSfVCNZMYEGoqR8WZdh7kamM9FmuTgUAcNg9"
      config.access_token_secret = "lWcB87UqB8WMAvdcXqdS1r9YeJBawtkA8bLpkdRm7RlN3"
    end
  end

  def authenticate
    redirect_to login_path unless current_user
  end

  def current_user
    User.find(session[:current_user_id]) if session[:current_user_id]
  end

end
