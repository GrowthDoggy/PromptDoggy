class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Log the user in and redirect to the homepage
      session[:user_id] = @user.id
      flash[:success] = "Your account has been successfully created!"
      redirect_to root_path
    else
      flash[:error] = "Registration failed. Please check your input and try again."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
