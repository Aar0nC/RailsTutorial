class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user].permit(:name, :email, :password, :password_confirmation))

    respond_to do |format|
      if @user.save
        flash[:success] = "Welcome to the Sample App, #{@user.name}!"
        log_in @user
        format.html { redirect_to @user }
      else
        format.html { render :new }
      end
    end
  end
end
