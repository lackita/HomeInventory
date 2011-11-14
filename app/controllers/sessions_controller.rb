class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    session[:openid_url] = auth["uid"]
    user = User.find_by_openid_url(auth["uid"])
    if user
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.openid_url}"
      redirect_to user
    else
      redirect_to new_user_path
    end
  end

  def destroy
    flash[:success] = "Goodbye, #{session[:openid_url]}"
    session[:openid_url] = nil
    session[:user_id] = nil
    redirect_to "/"
  end
end
