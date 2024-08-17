class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      render :new, status: :unauthorized, flash: { error: "Invalid email or password" }
    end
  end

  def destroy
    log_out
    redirect_to login_path, flash: { success: "You have successfully logged out" }
  end
end
