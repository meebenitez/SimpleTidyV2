class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  #before_action :authenticate_user!

  def index
    redirect_to lists_path
  end

  def after_sign_in_path_for(resource)
    #binding.pry
    request.env['omniauth.origin'] || lists_path
  end

end