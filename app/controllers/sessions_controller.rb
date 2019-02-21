class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post "http://github.com/login/oauth/authorize" do |req|
      #byebug
  req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'], 'client_secret': ENV['GITHUB_CLIENT_SECRET'], 'code': params["code"] }
  req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(response.body)
    session[:token] = body["access_token"]
    redirect_to controller: :repositories, action: :index, method: :get
  end

end
