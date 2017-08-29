class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Successful login, #{user.name.partition(" ").first}"
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    user = User.find(session[:user_id])
    flash[:success] = "Bye for now, #{user.name.partition(" ").first}"
    log_out
    redirect_to root_path
  end
end
