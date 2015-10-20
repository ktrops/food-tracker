class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path, notice: "signed Up!"
    else
      render :new
    end
  end

  def index
    @user = User.find(session[:user_id])
  end

  def user_params
    params.require(:user).permit(:email, :phone, :password, :password_confirmation)
  end
end
