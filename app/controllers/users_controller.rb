class UsersController < ApplicationController

  def new

  end

  def create
    #binding.pry
    user = User.new(user_params)
    #binding.pry
    if user.save
      session[:user_id] = user.id
      flash[:notice] = "You are now logged in #{params[:name]}"
      redirect_to "/profile"

    else

      flash[:notice] = user.errors.full_messages.join(". ").to_s
      redirect_to "/register"
    end
  end





  private

  def user_params

    params.permit(:name, :address, :state, :city, :zip, :email, :password, :password_confirmation)
  end


end
