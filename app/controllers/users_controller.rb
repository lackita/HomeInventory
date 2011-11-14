class UsersController < ApplicationController
  def new
    @user = User.new
    @user.openid_url = session[:openid_url]
  end

  def create
    user = User.new params[:user]
    user.save
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.openid_url}"
    redirect_to user
  end

  def show
    user = User.find(session[:user_id])
    @items = user.item

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end
end
