class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

  def authenticate_user
    if !logged_in?
      redirect_to "https://github.com/login/oauth/authorize"
    else
      redirect_to controller: :sessions, action: :create, method: :post
    end
  end

  def logged_in?
    return !!session[:token]
  end

end
