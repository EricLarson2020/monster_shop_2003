class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    #where returns a collection vs find_by.
    # if @user.save
    #   session[:id] = @user.id
    #   session[:user_id] = @user.id
    #   flash[:notice] = "You are now logged in #{user_params[:name]}"
    #   redirect_to "/profile"
    # else
    #   flash[:error] = @user.errors.full_messages.join(". ").to_s
    #   redirect_to "/register"
    # end

    if User.where(email:@user.email) != []
      flash[:error] = "Email has already been taken"
      redirect_to "/register"
    elsif @user.save
      session[:id] = @user.id
      session[:user_id] = @user.id
      flash[:notice] = "You are now logged in #{user_params[:name]}"
      redirect_to "/profile"
    else
      flash[:notice] = @user.errors.full_messages.join(". ").to_s
      redirect_to "/register"
    end
  end

  private

  def user_params
    params.permit(:name, :address, :state, :city, :zip, :email, :password, :password_confirmation)
  end
end
