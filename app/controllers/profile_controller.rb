class ProfileController < ApplicationController

  def index 
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    binding.pry
    if @user.save
      flash[:success] = "Your profile has been updated"
      redirect_to "/profile"
    # else
    #   flash[:error] = @user.errors.full_messages.to_s
    #   render :edit
    end
  end

  private
  def user_params
    params.permit(:name, :email, :address, :city, :state, :zip)
  end



end
