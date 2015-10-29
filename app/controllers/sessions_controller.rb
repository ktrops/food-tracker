class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_food_path(@user.id), notice: "Logged In!"
    else
      flash[:notice] = @user.errors.messages
      render "new"
    end
  end

  def oauth
    # binding.pry
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to user_food_path(session[:user_id]), notice: "Signed In!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged Out!"
  end
end
