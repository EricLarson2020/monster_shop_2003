class UsersController < ApplicationController

  def new

  end

  def create

    user = User.new(user_params)

    if user.save
      flash[:notice] = "You are now logged in #{params[:name]}"
      redirect_to "/profile"

    else

      flash[:notice] = user.errors.full_messages.join(". ").to_s
      redirect_to "/register"
    end
  end





  private

  def user_params

    params.permit(:name, :address, :state, :city, :zip, :email, :password)
  end


end
