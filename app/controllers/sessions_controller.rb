class SessionsController < ApplicationController
	def new
	end

	def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
  	session[:user_id] = nil
    cookies.delete :sample_app_session
    sleep 1
  	redirect_to root_url
  end
end
